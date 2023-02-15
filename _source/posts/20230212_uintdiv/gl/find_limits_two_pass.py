import distutils.spawn
import re
import time
import subprocess
from OpenGL.GL import *
from OpenGL.GLUT import *


COMMON_HEADER = """
#version 460 core
layout(local_size_x=64, local_size_y=16) in;

#define asfloat  uintBitsToFloat
#define asuint   floatBitsToUint
#define rcp(x)   (1./x)


float newton_opt(float x, float k)
{
    // Cubic error correction
#if 0
    float E = 1.0f - k * x;
    float Y = x * E;
    return x + Y + Y * E;
#else
    // 2x mad, 1 mul, 1 mac
    float a = -k * x + 1;
    float b = a * x + x;
    return a * a * x + b;
#endif
}



// Not ~16777217 yet



// 44 cycles
// INTEL: a <= 2686594, b <= 2686594 (actually worse)
uint fastUintDivNewton(uint a, uint b)
{
    float bf = float(b);
    float bfi = rcp(float(b));
          bfi = bfi * (2.0f - bf * bfi);
    return uint(asfloat(2u + asuint(float(a) * bfi)));
}



// 36 cycle variety
// INTEL: a <= 2888384, b <= 2888384
// NVIDIA:  a <= 2862823, b <= 2862823
uint fastUintDiv(uint a, uint b)
{
    return uint(asfloat(2u + asuint(float(a) * rcp(float(b)))));
}


// 36 cycle variety
// INTEL: a <= 4221778, b <= 4221778
// NVIDIA: a <= 4710613, b <= 7918     :(
uint fastUintDiv2(uint a, uint b)
{
    return uint(float(a) * 1.0 / asfloat(asuint(float(b)) - 1u));
}



// 32 cycles variety
uint fasterUintDiv(uint a, uint b)
{
    // INTEL: a <= 10758, b <= 10758
    // NVIDIA: a <= 65208, b <= 32713
    return uint(float(a) * rcp(float(b)) + asfloat(0x38000001u));

    // INTEL: a <= 5382, b <= 5382
    // NVIDIA: a <= 63158, b <= 63158
    return uint(float(a) * rcp(float(b)) + asfloat(0x37800000));
    
    // INTEL: a <= 21510, b <= 16363
    // NVIDIA: a <= 32712, b <= 16371
    return uint(float(a) * rcp(float(b)) + asfloat(0x38800000));
}


"""


WRITE_CORRECT_VALUES_BASE = """

layout(location = 0) uniform uvec2 offset;
layout(std430, binding = 0) buffer writeback_
{
    uint values[];
};

void main()
{
    uint x = offset.x + gl_GlobalInvocationID.x;
    uint y = offset.y + gl_GlobalInvocationID.y;
    uint gid = gl_GlobalInvocationID.y * gl_WorkGroupSize.x * gl_NumWorkGroups.x + gl_GlobalInvocationID.x;

#if UPPER_DENOM_LIMIT
    y = min(UPPER_DENOM_LIMIT, offset.y + gl_GlobalInvocationID.y);
#endif // UPPER_DENOM_LIMIT

    values[gid] = x / y;
}


"""


PROBE_FASTER_UINT_DIV_BASE = """

layout(location = 0) uniform uvec2 offset;
layout(std430, binding = 0) buffer readin_
{
    uint values[];
};
layout(std430, binding = 1) buffer writeback_
{
    uint allocator;
    uint failedOffsets[];
};

void main()
{
    uint x = offset.x + gl_GlobalInvocationID.x;
    uint y = offset.y + gl_GlobalInvocationID.y;
    uint gid = gl_GlobalInvocationID.y * gl_WorkGroupSize.x * gl_NumWorkGroups.x + gl_GlobalInvocationID.x;

#if UPPER_DENOM_LIMIT
    y = min(UPPER_DENOM_LIMIT, offset.y + gl_GlobalInvocationID.y);
#endif // UPPER_DENOM_LIMIT

    uint z0 = values[gid];
    uint z1 = TARGET_FAST_UINT_DIV_FUNC(x, y);

    if(z0 != z1)
    {
        uint writeAddr = atomicAdd(allocator, 1);
        failedOffsets[writeAddr*2 + 0] = x;
        failedOffsets[writeAddr*2 + 1] = y;
    }
}

"""


# On windows this will be usually inside one of the nested directories in
# C:\Windows\System32\DriverStore\FileRepository
_NVIDIA_SMI_EXEC = distutils.spawn.find_executable("nvidia-smi")
_MAX_NVIDIA_TEMP_UNTIL_SLEEP = 60
_MAX_NVIDIA_TEMP_UNTIL_RESUME = 57


def _get_nvidia_temp():
    """Get the current tempreture of an nvidia gpu, using nvidia-smi"""
    if _NVIDIA_SMI_EXEC is None:
        raise RuntimeError("Can't find nvidia-smi! Add it to the path variable!")
    csv_data = (
        subprocess.Popen(
            (_NVIDIA_SMI_EXEC, "--query-gpu=temperature.gpu", "--format=csv"),
            stdout=subprocess.PIPE,
            close_fds=True,
        )
        .stdout.read()
        .decode("latin-1")
    )

    # Considering im just targetting my system, im totally assuming there
    # will be exactly 1 NVIDIA GPU.
    extracted = re.search(r"temperature.gpu\s+(\d+)\s+", csv_data)
    if not extracted:
        raise RuntimeError("Failed to get temperature!")
    return float(extracted.group(1))


def _prevent_nvidia_overheating():
    """This is a bit of a hack to prevent my system from overheating."""
    if _get_nvidia_temp() >= _MAX_NVIDIA_TEMP_UNTIL_SLEEP:
        print("Sleeping until NVIDIA GPU calms down!")
        while _get_nvidia_temp() > _MAX_NVIDIA_TEMP_UNTIL_RESUME:
            time.sleep(10)


def _make_write_correct_shader(upper_denom_limit=None):
    """Generate shader source code for writing correct divisions.

    Args:
        upper_denom_limit (int): Max number denom can be. (Default: None)

    Returns:
        str: Generated source
    """
    shader = COMMON_HEADER
    if upper_denom_limit:
        shader += "#define UPPER_DENOM_LIMIT {0}\n".format(upper_denom_limit)
    shader += WRITE_CORRECT_VALUES_BASE
    return shader


def _make_probe_shader(function, upper_denom_limit=None):
    """Generate shader source code for probing the divisor limits.

    Args:
        function (str): Name of function to test
        upper_denom_limit (int): Max number denom can be. (Default: None)

    Returns:
        str: Generated source
    """
    shader = COMMON_HEADER
    shader += "#define TARGET_FAST_UINT_DIV_FUNC {0}\n".format(function)
    if upper_denom_limit:
        shader += "#define UPPER_DENOM_LIMIT {0}\n".format(upper_denom_limit)
    shader += PROBE_FASTER_UINT_DIV_BASE
    return shader


def compile_compute_program(source):
    """Generate a compute program."""
    # Compile shader
    shader_id = glCreateShader(GL_COMPUTE_SHADER)
    glShaderSource(shader_id, source, 0)
    glCompileShader(shader_id)
    ok = glGetShaderiv(shader_id, GL_COMPILE_STATUS)
    if not ok:
        error_log = glGetShaderInfoLog(shader_id)
        raise RuntimeError(
            "Failed to load shader:\n{0}".format(
                error_log.decode("latin-1"),
            )
        )
    # Attach to program
    main_program = glCreateProgram()

    glAttachShader(main_program, shader_id)
    glLinkProgram(main_program)

    ok = glGetProgramiv(main_program, GL_LINK_STATUS)
    if not ok:
        error_log = glGetProgramInfoLog(main_program)
        raise RuntimeError(
            "Failed to link program:\n{0}".format(error_log.decode("latin-1"))
        )
    # Cleanup
    glDetachShader(main_program, shader_id)
    glDeleteShader(shader_id)

    return main_program


class GPUContext(object):
    def __init__(self):
        # Create a dummy 1x1 window just to get GL up and running
        glutInitContextVersion(4, 6)
        glutInitContextProfile(GLUT_CORE_PROFILE)
        glutInitContextFlags(GLUT_FORWARD_COMPATIBLE)
        glutInit()
        glutInitDisplayMode(GLUT_RGBA | GLUT_DEPTH | GLUT_STENCIL | GLUT_DOUBLE)
        glutInitWindowSize(1, 1)

        glutCreateWindow(b"Find Limits")
        glutDisplayFunc(self._draw_wrapper)

        self.init()
        glutMainLoop()

    def _draw_wrapper(self):
        start_time = time.time()
       
        if self._prevent_overheating:
            _prevent_nvidia_overheating()

        # Redraw to the screen every second, so we're not wasting
        # time waiting for vsyncs, but also dont want it to be marked
        # as not responsive.
        while time.time() - start_time < 1:
            self.draw()
        
        glutPostRedisplay()
        glutSwapBuffers()

    def init(self):
        # Swap this if your GPU isn't liable to melt your motherboard
        self._prevent_overheating = True

        if self._prevent_overheating and (b"NVIDIA" not in glGetString(GL_VENDOR)):
            self._prevent_overheating = False
        self._x = 0
        self._y = 0
        self._tile_size_x = 64
        self._tile_size_y = 16
        self._dispatch_size_x = 16
        self._dispatch_size_y = 64
        self._per_iteration_x = self._tile_size_x * self._dispatch_size_x
        self._per_iteration_y = self._tile_size_y * self._dispatch_size_y
        self._max_x = ((1 << 32) - 1) // (self._per_iteration_x)
        self._max_dispatch_range = self._per_iteration_x * self._per_iteration_y

        self._correct_divison_ptr = ctypes.c_int()
        glCreateBuffers(1, self._correct_divison_ptr)
        self._correct_divison = self._correct_divison_ptr.value
        glNamedBufferStorage(
            self._correct_divison,
            (1 + self._max_dispatch_range) * 4,
            None,
            0,
        )

        self._writeback_failures_ptr = ctypes.c_int()
        glCreateBuffers(1, self._writeback_failures_ptr)
        self._writeback_failures = self._writeback_failures_ptr.value
        glNamedBufferStorage(
            self._writeback_failures,
            (1 + self._max_dispatch_range) * 4,
            bytes((1 + self._max_dispatch_range) * 4),  # Fill with nulls
            GL_MAP_READ_BIT,
        )

        self.denom_upper_limit = None
        self._target_function = "fastUintDiv2"
        self._write_correct_program = compile_compute_program(
            _make_write_correct_shader()
        )
        self._test_fast_uint_div_program = compile_compute_program(
            _make_probe_shader(self._target_function)
        )

        glUseProgram(self._test_fast_uint_div_program)
        glBindBufferBase(GL_SHADER_STORAGE_BUFFER, 0, self._writeback_failures)

    def _barrier_read_fails(self):
        glMemoryBarrier(GL_BUFFER_UPDATE_BARRIER_BIT)
        num_failed = (c_int * 1)()
        glGetNamedBufferSubData(self._writeback_failures, 0, 4, num_failed)

        found = []
        if num_failed[0] != 0:
            ints_to_read = 1 + 2 * num_failed[0]
            bad_params = (c_int * ints_to_read)()
            glGetNamedBufferSubData(self._writeback_failures, 0, 4 * ints_to_read, bad_params)
            for i in range(num_failed[0]):
                x = bad_params[1 + i * 2 + 0]
                y = bad_params[1 + i * 2 + 1]
                found.append((x, y))
        return found

    def find_denominator(self):
        offset_x = 1 + self._x * self._per_iteration_x
        offset_y = 1 + self._y * self._per_iteration_y

        glUseProgram(self._write_correct_program)
        glBindBufferBase(GL_SHADER_STORAGE_BUFFER, 0, self._correct_divison)
        glUniform2ui(0, offset_x, offset_y)
        glDispatchCompute(self._dispatch_size_x, self._dispatch_size_y, 1)

        glMemoryBarrier(GL_SHADER_STORAGE_BARRIER_BIT)

        glUseProgram(self._test_fast_uint_div_program)
        glBindBufferBase(GL_SHADER_STORAGE_BUFFER, 0, self._correct_divison)
        glBindBufferBase(GL_SHADER_STORAGE_BUFFER, 1, self._writeback_failures)
        glUniform2ui(0, offset_x, offset_y)
        glDispatchCompute(self._dispatch_size_x, self._dispatch_size_y, 1)

        next_offset_x = offset_x + self._per_iteration_x
        next_offset_y = offset_y + self._per_iteration_y

        print(
            "Running [{0}, {1}] => [{2}, {3}]".format(
                offset_x, offset_y, next_offset_x, next_offset_y
            )
        )

        failed = self._barrier_read_fails()

        if failed:
            print("Failed!:")
            for x, y in failed:
                print("    {0}/{1}".format(x, y))
            numerator_upper_limit = min(numerator for numerator, _ in failed)
            denom_upper_limit = min(denom for _, denom in failed)

            print("\nMIN {0}/{1}".format(numerator_upper_limit, denom_upper_limit))

            # We iterate the values alongside each other
            # So if order for `1000/6` or `6/1000` to have failed,
            # 1/1 => 999/999 would have already had to have passed.
            #
            # The true upper limit is going to be which ever value
            # is bigger out of the mins, minus one.
            self.denom_upper_limit = max(numerator_upper_limit, denom_upper_limit) - 1

            print("Denominator upper bound: {0}".format(self.denom_upper_limit))

            # Change shader to now clamp to the denominator
            self._write_correct_program = compile_compute_program(
                _make_write_correct_shader(self.denom_upper_limit)
            )
            self._test_fast_uint_div_program = compile_compute_program(
                _make_probe_shader(self._target_function, self.denom_upper_limit)
            )

            # And clear the counter
            glClearNamedBufferSubData(
                self._writeback_failures,
                GL_R32UI,
                0,
                4,
                GL_RED_INTEGER,
                GL_UNSIGNED_INT,
                bytes(4),
            )
        else:
            self._y += 1
            if next_offset_y >= next_offset_x:
                self._x += 1
                self._y = 0
                if self._x >= self._max_x:
                    print("ALL DONE!")
                    exit(0)

    def find_numerator(self):
        offset_x = 1 + self._x * self._per_iteration_x
        offset_y = 1 + self._y * self._per_iteration_y

        glUseProgram(self._write_correct_program)
        glBindBufferBase(GL_SHADER_STORAGE_BUFFER, 0, self._correct_divison)
        glUniform2ui(0, offset_x, offset_y)
        glDispatchCompute(self._dispatch_size_x, self._dispatch_size_y, 1)

        glMemoryBarrier(GL_SHADER_STORAGE_BARRIER_BIT)

        glUseProgram(self._test_fast_uint_div_program)
        glBindBufferBase(GL_SHADER_STORAGE_BUFFER, 0, self._correct_divison)
        glBindBufferBase(GL_SHADER_STORAGE_BUFFER, 1, self._writeback_failures)
        glUniform2ui(0, offset_x, offset_y)
        glDispatchCompute(self._dispatch_size_x, self._dispatch_size_y, 1)

        next_offset_x = offset_x + self._per_iteration_x
        next_offset_y = offset_y + self._per_iteration_y

        print(
            "Running [Searching ??? / {4}] [{0}, {1}] => [{2}, {3}]".format(
                offset_x, offset_y, next_offset_x, next_offset_y, self.denom_upper_limit
            )
        )

        failed = self._barrier_read_fails()
        if failed:
            print("Failed!:")
            for x, y in failed:
                print("    {0}/{1}".format(x, y))
            self.numerator_upper_limit = min(numerator for numerator, _ in failed) - 1

            print(
                "(a/b) : a <= {0}, b <= {1}".format(
                    self.numerator_upper_limit, self.denom_upper_limit
                )
            )
            exit(0)
        else:
            self._y += 1
            if next_offset_y >= min(self.denom_upper_limit + 1, next_offset_x):
                self._x += 1
                self._y = 0
                if self._x >= self._max_x:
                    print("ALL DONE!")
                    exit(0)

    def draw(self):
        if self.denom_upper_limit:
            self.find_numerator()
        else:
            self.find_denominator()


if __name__ == "__main__":
    ctx = GPUContext()
