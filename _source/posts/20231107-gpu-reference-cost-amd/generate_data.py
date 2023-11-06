import os
import re
import shutil
import sys
import subprocess
import tempfile

sys.path.insert(
    0,
    os.path.abspath(
        os.path.join(
            __file__,
            "..",
            "..",
            "..",
            ".."
        )
    )
)

from builder.find_exec import find_executable


_DXC_PATH = find_executable("dxc", "DXC_PATH")
_SPIRV_OPT_PATH = find_executable("spirv-opt", "SPIRV_OPT_PATH")
_RGA_PATH = find_executable("rga", "RGA_PATH")
_ASIC_EXTRACTION_RE = re.compile(
    # --> gfx900 (Vega)
    r"^^(?P<asic>[A-Za-z0-9_][A-Za-z0-9_ ]+)"
    # gfx900 (Vega) <---
    r"(?P<family>[^\n]+)\n"
    # AMD Radeon Instinct MI25x2 MxGPU
    # Instinct MI25x2
    # Radeon (TM) PRO WX 8200
    # Radeon (TM) Pro WX 9100
    # Radeon Instinct MI25
    # Radeon Instinct MI25 MxGPU
    # Radeon Instinct MI25x2
    # Radeon Pro SSG
    # Radeon Pro V340
    # Radeon Pro V340 MxGPU
    # Radeon Pro Vega 56
    # Radeon RX Vega
    # Radeon Vega Frontier Edition
    # Radeon(TM) Pro V320
    r"(?P<gpu_types>(?:[ \t]+[^\n]+\n?)+)",
    flags = re.MULTILINE
)


_SIMPLE_TEMPLATE = """
float4 func(float4 value)
{
/* Setup */     %s
/* Function */  %s
/* Fixup */     %s
}

RWBuffer<float4> IOBuffer;
[numthreads(1, 1, 1)]
void main(uint3 tid : SV_DispatchThreadID)
{
    float4 value = IOBuffer[tid.x];
    value = func(value);
    IOBuffer[tid.x] = value;
}
"""

def get_rga_asic_support():
    """Get RGA asic support..

    Returns:
        list[dict]: Asic support mapping
    """
    vk_offline_proc = subprocess.Popen(
        (
            _RGA_PATH,
            "-s",
            "vk-spv-offline",
            "--list-asics"
        ),
        stdout = subprocess.PIPE
    )

    result = []
    vk_offline_proc.wait()
    vk_offline = vk_offline_proc.stdout.read()
    if not isinstance(vk_offline, str):
        vk_offline = vk_offline.decode("utf8")

    for match in _ASIC_EXTRACTION_RE.finditer(vk_offline):
        asic = match.group("asic").strip()
        family = match.group("family").strip().strip("()")
        gpu_types = match.group("gpu_types")
        gpu_types = [
            gpu_type.strip()
            for gpu_type in gpu_types.strip().split("\n")
        ]

        result.append({
            "name": "{0}".format(asic),
            "asic": asic,
            "family": family,
            "gpu_types": gpu_types,
        })
    return result


def run_experiment(hlsl, asic):

    def _tmpfile():
        result = tempfile.NamedTemporaryFile(delete=False)
        result.close()
        return result.name

    scratch_dir = tempfile.TemporaryDirectory().name
    os.makedirs(scratch_dir)
    tmp_hlsl = os.path.join(scratch_dir, "tmp.hlsl")
    tmp_spv = os.path.join(scratch_dir, "tmp.spv")

    try:
        with open(tmp_hlsl, "w") as out_hlsl:
            out_hlsl.write(hlsl)

        subprocess.check_call([
            _DXC_PATH,
            "-spirv",
            "-fspv-target-env=vulkan1.2",
            "-T cs_6_0",
            "-O3",
            tmp_hlsl,
            "-Fo",
            tmp_spv
        ])

        subprocess.check_call([
            _SPIRV_OPT_PATH,
            "--legalize-hlsl",
            "--strip-debug",
            "--strip-nonsemantic",
            "-O",
            tmp_spv,
            "-o",
            tmp_spv
        ])

        analysis_dir = os.path.join(scratch_dir, "a")
        isa_dir = os.path.join(scratch_dir, "isa")
        os.makedirs(analysis_dir)
        os.makedirs(isa_dir)

        command = [
            _RGA_PATH,
            "-s",
            "vk-spv-offline",
            "-c",
            asic,
            "--isa",
            os.path.join(isa_dir, "isa.amdisa"),
            "--parse-isa",
            "-a",
            os.path.join(analysis_dir, "a.csv"),
            "--comp",
            tmp_spv
        ]

        proc = subprocess.Popen(
            command, stdout=subprocess.PIPE, stderr=subprocess.PIPE
        )

        analysis_file = os.path.join(
            analysis_dir,
            "{0}_a_comp.csv".format(asic),
        )
        isa_file = os.path.join(
            isa_dir,
            "{0}_isa_comp.amdisa".format(asic),
        )
        parsed_isa_file = os.path.join(
            isa_dir,
            "{0}_isa_comp.csv".format(asic),
        )

        proc.wait()
        
        # rga doesn't gracefully return a bad error code
        # or even write to stderr, so we check if all the
        # outputs we expect to be made exist, if not, we
        # assume an error.
        if not all(
                os.path.isfile(path)
                for path in (analysis_file, isa_file, parsed_isa_file)
        ):
            stdout = proc.stdout.read()
            if not isinstance(stdout, str):
                stdout = stdout.decode("utf8")
            raise RuntimeError("RGA failed: {0}".format(stdout))


        print(parsed_isa_file)
        input()
        

    finally:
        shutil.rmtree(scratch_dir)




if __name__ == "__main__":
    if not _RGA_PATH:
        raise RuntimeError("rga not found in $PATH or $RGA_PATH")
    if not _DXC_PATH:
        raise RuntimeError("dxc not found in $PATH or $DXC_PATH")
    print(get_rga_asic_support())

    run_experiment(_SIMPLE_TEMPLATE % ("", "", "return value.x * value.y + value.z;"), "gfx1103");