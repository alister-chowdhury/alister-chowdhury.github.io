import os
from numpy import float32
import re

from .._cache import _test_cache, _insert_cache


_CACHE_DIR = os.path.abspath(os.path.join(__file__, "..", ".cache", "glsl"))


_RESERVED_WORDS = {
    "abs",
    "acos",
    "acosh",
    "active",
    "all",
    "any",
    "asin",
    "asinh",
    "asm",
    "atan",
    "atanh",
    "atomic_uint",
    "atomicAdd",
    "atomicAnd",
    "atomicCompSwap",
    "atomicCounter",
    "atomicCounterDecrement",
    "atomicCounterIncrement",
    "atomicExchange",
    "atomicMax",
    "atomicMin",
    "atomicOr",
    "atomicXor",
    "attribute",
    "barrier",
    "binding",
    "bitCount",
    "bitfieldExtract",
    "bitfieldInsert",
    "bitfieldReverse",
    "bool",
    "break",
    "buffer",
    "bvec2",
    "bvec3",
    "bvec4",
    "case",
    "cast",
    "ccw",
    "ceil",
    "centroid",
    "clamp",
    "class",
    "coherent",
    "column_major",
    "common",
    "const",
    "continue",
    "cos",
    "cosh",
    "cross",
    "cw",
    "default",
    "degrees",
    "depth_any",
    "depth_greater",
    "depth_less",
    "depth_unchanged",
    "determinant",
    "dFdx",
    "dFdxCoarse",
    "dFdxFine",
    "dFdy",
    "dFdyCoarse",
    "dFdyFine",
    "discard",
    "distance",
    "dmat2",
    "dmat2x2",
    "dmat2x3",
    "dmat2x4",
    "dmat3",
    "dmat3x2",
    "dmat3x3",
    "dmat3x4",
    "dmat4",
    "dmat4x2",
    "dmat4x3",
    "dmat4x4",
    "do",
    "dot",
    "double",
    "dvec2",
    "dvec3",
    "dvec4",
    "early_fragment_tests",
    "else",
    "EmitStreamVertex",
    "EmitVertex",
    "EndPrimitive",
    "EndStreamPrimitive",
    "enum",
    "equal",
    "equal_spacing",
    "exp",
    "exp2",
    "extern",
    "external",
    "faceforward",
    "false"
    "filter",
    "findLSB",
    "findMSB",
    "fixed",
    "flat",
    "float",
    "floatBitsToInt",
    "floatBitsToUint",
    "floor",
    "fma",
    "for",
    "fract",
    "fractional_even_spacing",
    "fractional_odd_spacing",
    "frexp",
    "ftransform",
    "fvec2",
    "fvec3",
    "fvec4",
    "fwidth",
    "fwidthCoarse",
    "fwidthFine",
    "goto",
    "greaterThan",
    "greaterThanEqual",
    "groupMemoryBarrier",
    "half",
    "highp",
    "hvec2",
    "hvec3",
    "hvec4",
    "if",
    "iimage1D",
    "iimage1DArray",
    "iimage2D",
    "iimage2DArray",
    "iimage2DMS",
    "iimage2DMSArray",
    "iimage2DRect",
    "iimage3D",
    "iimageBuffer",
    "iimageCube",
    "iimageCubeArray",
    "image1D",
    "image1DArray",
    "image1DArrayShadow",
    "image1DShadow",
    "image2D",
    "image2DArray",
    "image2DArrayShadow",
    "image2DMS",
    "image2DMSArray",
    "image2DRect",
    "image2DShadow",
    "image3D",
    "imageAtomicAdd",
    "imageAtomicAnd",
    "imageAtomicCompSwap",
    "imageAtomicExchange",
    "imageAtomicMax",
    "imageAtomicMin",
    "imageAtomicOr",
    "imageAtomicXor",
    "imageBuffer",
    "imageCube",
    "imageCubeArray",
    "imageLoad",
    "imageSamples",
    "imageSize",
    "imageStore",
    "imulExtended",
    "in",
    "index",
    "inline",
    "inout",
    "input",
    "int",
    "intBitsToFloat",
    "interface",
    "interpolateAtCentroid",
    "interpolateAtOffset",
    "interpolateAtSample",
    "invariant",
    "inverse",
    "inversesqrt",
    "invocations",
    "isampler1D",
    "isampler1DArray",
    "isampler2D",
    "isampler2DArray",
    "isampler2DMS",
    "isampler2DMSArray",
    "isampler2DRect",
    "isampler3D",
    "isamplerBuffer",
    "isamplerCube",
    "isamplerCubeArray",
    "isinf",
    "isnan",
    "isolines",
    "ivec2",
    "ivec3",
    "ivec4",
    "layout",
    "ldexp",
    "length",
    "lessThan",
    "lessThanEqual",
    "line_strip",
    "lines",
    "lines_adjacency",
    "local_size_x",
    "local_size_y",
    "local_size_z",
    "location",
    "log",
    "log2",
    "long",
    "lowp",
    "main",
    "mat2",
    "mat2x2",
    "mat2x3",
    "mat2x4",
    "mat3",
    "mat3x2",
    "mat3x3",
    "mat3x4",
    "mat4",
    "mat4x2",
    "mat4x3",
    "mat4x4",
    "matrixCompMult",
    "max",
    "max_vertices",
    "mediump",
    "memoryBarrier",
    "memoryBarrierAtomicCounter",
    "memoryBarrierBuffer",
    "memoryBarrierImage",
    "memoryBarrierShared",
    "min",
    "mix",
    "mod",
    "modf",
    "namespace",
    "noinline",
    "noise",
    "noise1",
    "noise2",
    "noise3",
    "noise4",
    "noperspective",
    "normalize",
    "not",
    "notEqual",
    "offset",
    "origin_upper_left",
    "out",
    "outerProduct",
    "output",
    "packDouble2x32",
    "packed",
    "packHalf2x16",
    "packSnorm2x16",
    "packSnorm4x8",
    "packUnorm",
    "packUnorm2x16",
    "packUnorm4x8",
    "partition",
    "patch",
    "pixel_center_integer",
    "point_mode",
    "points",
    "pow",
    "precise",
    "precision",
    "public",
    "quads",
    "r11f_g11f_b10f",
    "r16",
    "r16_snorm",
    "r16f",
    "r16i",
    "r16ui",
    "r32f",
    "r32i",
    "r32ui",
    "r8",
    "r8_snorm",
    "r8i",
    "r8ui",
    "radians",
    "readonly",
    "reflect",
    "refract",
    "restrict",
    "return",
    "rg16",
    "rg16_snorm",
    "rg16f",
    "rg16i",
    "rg16ui",
    "rg32f",
    "rg32i",
    "rg32ui",
    "rg8",
    "rg8_snorm",
    "rg8i",
    "rg8ui",
    "rgb10_a2",
    "rgb10_a2ui",
    "rgba16",
    "rgba16_snorm",
    "rgba16f",
    "rgba16i",
    "rgba16ui",
    "rgba32f",
    "rgba32i",
    "rgba32ui",
    "rgba8",
    "rgba8_snorm",
    "rgba8i",
    "rgba8ui",
    "round",
    "roundEven",
    "row_major",
    "sample",
    "sampler1D",
    "sampler1DArray",
    "sampler1DArrayShadow",
    "sampler1DShadow",
    "sampler2D",
    "sampler2DArray",
    "sampler2DArrayShadow",
    "sampler2DMS",
    "sampler2DMSArray",
    "sampler2DRect",
    "sampler2DRectShadow",
    "sampler2DShadow",
    "sampler3D",
    "sampler3DRect",
    "samplerBuffer",
    "samplerCube",
    "samplerCubeArray",
    "samplerCubeArrayShadow",
    "samplerCubeShadow",
    "shadow1D",
    "shadow1DLod",
    "shadow1DProj",
    "shadow1DProjLod",
    "shadow2D",
    "shadow2DLod",
    "shadow2DProj",
    "shadow2DProjLod",
    "shared",
    "short",
    "sign",
    "sin",
    "sinh",
    "sizeof",
    "smooth",
    "smoothstep",
    "sqrt",
    "static",
    "std140",
    "std430",
    "step",
    "stream",
    "subroutine",
    "superp",
    "switch",
    "tan",
    "tanh",
    "template",
    "texelFetch",
    "texelFetchOffset",
    "texture",
    "texture1D",
    "texture1DLod",
    "texture1DProj",
    "texture1DProjLod",
    "texture2D",
    "texture2DLod",
    "texture2DProj",
    "texture2DProjLod",
    "texture3D",
    "texture3DLod",
    "texture3DProj",
    "texture3DProjLod",
    "textureCube",
    "textureCubeLod",
    "textureGather",
    "textureGatherOffset",
    "textureGatherOffsets",
    "textureGrad",
    "textureGradOffset",
    "textureLod",
    "textureLodOffset",
    "textureOffset",
    "textureProj",
    "textureProjGrad",
    "textureProjGradOffset",
    "textureProjLod",
    "textureProjLodOffset",
    "textureProjOffset",
    "textureQueryLevels",
    "textureQueryLod",
    "textureSamples",
    "textureSize",
    "this",
    "transpose",
    "triangle_strip",
    "triangles",
    "triangles_adjacency",
    "true",
    "trunc",
    "typedef",
    "uaddCarry",
    "uimage1D",
    "uimage1DArray",
    "uimage2D",
    "uimage2DArray",
    "uimage2DMS",
    "uimage2DMSArray",
    "uimage2DRect",
    "uimage3D",
    "uimageBuffer",
    "uimageCube",
    "uimageCubeArray",
    "uint",
    "uintBitsToFloat",
    "umulExtended",
    "uniform",
    "union",
    "unpackDouble2x32",
    "unpackHalf2x16",
    "unpackSnorm2x16",
    "unpackSnorm4x8",
    "unpackUnorm",
    "unpackUnorm2x16",
    "unpackUnorm4x8",
    "unsigned",
    "usampler1D",
    "usampler1DArray",
    "usampler2D",
    "usampler2DArray",
    "usampler2DMS",
    "usampler2DMSArray",
    "usampler2DRect",
    "usampler3D",
    "usamplerBuffer",
    "usamplerCube",
    "usamplerCubeArray",
    "using",
    "usubBorrow",
    "uvec2",
    "uvec3",
    "uvec4",
    "varying",
    "vec2",
    "vec3",
    "vec4",
    "vertices",
    "void",
    "volatile",
    "while",
    "writeonly",
}


def _minify_shader_name_generator(reserved_words):
    """Generate shader variable names.

    Args:
        reserved_words (set[str]): Names which are reserved.

    Yields:
        str: Variable name.
    """
    remap_first_chars = "_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    remap_other_chars = "_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    next_id = 0
    
    while True:
        current_id = next_id
        next_id += 1
        current_name = remap_first_chars[current_id % len(remap_first_chars)]
        current_id = current_id // len(remap_first_chars)
        
        while current_id:
            current_name += remap_other_chars[current_id % (len(remap_other_chars) + 1) - 1]
            current_id //= len(remap_other_chars) + 1

        if current_name.lower().startswith("gl"):
            continue

        if "__" in current_name:
            continue

        if current_name not in reserved_words:
            yield current_name


def minify_glsl(source):
    """Minify WebGL GLSL shader (emitted from spirv-cross).

    Args:
        source (str): spirv-cross emitted shader source.

    Returns:
        str: Minified shader.
    """
    found, cached = _test_cache(_CACHE_DIR, source)
    if found:
        return cached

    minified = source

    # rename spirv-cross auto named variables to use less characters
    local_reserved_words = {
        found[1]
        for found in re.findall(
            r"(uniform|in|out) .* (.+);$",
            minified,
            flags=re.MULTILINE
        )
    }
    local_reserved_words.update(_RESERVED_WORDS)
    name_generator = _minify_shader_name_generator(local_reserved_words)
    rename_mapping = {}

    def _rename_variable(match):
        """Fetch or create a corresponding minified variable name.

        Args:
            match (re.Match): Regex match object.

        Returns:
            str: Minified variable name.
        """
        var_name = match.group(1)

        if var_name in rename_mapping:
            return rename_mapping[var_name]

        new_name = next(name_generator)
        rename_mapping[var_name] = new_name
        return new_name

    # _1, _2, _30 etc is how spirv names its temporaries
    minified = re.sub(r"((?<![a-zA-Z0-9_])_\d+)", _rename_variable, minified)

    # Strip uneeded casts
    minified = re.sub(
        r"uint\((\d+)\)",
        lambda x: "{0}u".format(x.group(1)),
        minified
    )

    # Minify numbers which have needless precision
    # e.g: 1.2000000476837158203125 => 1.2
    minified = re.sub(
        r"([+\-]?\d+\.\d+)",
        lambda x: str(float32(x.group(1))),
        minified
    )

    # Remove 0 suffixes from floats
    # 0.0 => 0.
    # 1.0 => 1.
    minified = re.sub(r"(\d+\.)0+(?!\d)", lambda x: x.group(1), minified)

    # Remove 0 prefixes from floats
    # 0.01 => .01
    # 0.1 => .1
    minified = re.sub(r"(?<!\d)0+(\.\d+)", lambda x: x.group(1), minified)

    # remove excessive whitespace
    minified = re.sub("\n+", "\n", minified)
    minified = re.sub(r" +", " ", minified)

    # TODO: Should probably explicitly ignore any line that starts with "#"
    minified = re.sub(
        r"\s*([\[\]+\-\*^|&<>{};:\?\=,\(\)\!\~/])\s*",
        lambda x: x.group(1),
        minified
    )

    _insert_cache(_CACHE_DIR, source, minified)

    return minified
