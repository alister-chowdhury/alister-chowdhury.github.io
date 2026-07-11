# Approx Root

Functions for calculating magic numbers that help when approximating roots.

The general form for using said magic numbers is:

```cpp
    // 3 full rate instructions (NVIDIA / AMD)
    float apply(float x) {
        const float iroot = ...; //  1/root, e.g: for cbrt, 1.0/3.0
        const float magic = ...; //  calculated magic
        return asfloat(uint(float(asuint(x)) * iroot + magic));
    }

    float inverse(float x) {
        const float root = ...;  // root, e.g: for cbrt, 3.0
        const float magic = ...; // calculated magic
        const float magic_root = (magic * root);
        return asfloat(uint(float(asuint(x)) * root - magic_root));
    }

    // 4 full rate instructions (NVIDIA / AMD)
    float apply(float x) {
        const float iroot = ...; //  1/root, e.g: for cbrt, 1.0/3.0
        const uint magic = ...;  //  calculated magic
        return asfloat(uint(float(asuint(x)) * iroot) + magic);
    }

    float inverse(float x) {
        const float root = ...; // root, e.g: for cbrt, 3.0
        const uint magic = ...; // calculated magic
        return asfloat(uint(float(asuint(x) - magic) * root));
    }
```

Implementation is C++, but interface is C.


## Usage

All of the functions expect you to provide the inverse root (`1/root`).

So `sqrt` would be 0.5, `cbrt` would (1.0/3.0), `qdrt` would be 0.25 etc.

Providing values less-equal to 0 or greater-equal to 1 will result it garbage results.


### Lowest Relative Error

For calculating the lowest relative error `abs((correct-approx)/correct)`, there are two functions you can use, which really trade time vs total accuracy.

#### `find_magic_rel_error`

Accurate variant.

Is quite slow (think around 100-200ms slow) and requires an external workspace to be provided.

Example usage:
```c
#include <stdio.h>
#include <stdlib.h>
#include <approx_root/find_magic_rel.h>

void calculate_cbrt() {
    // Workspace which is used as scratch space during calculation.
    // It's 64MB, so you probably don't want to allocate this on the stach.
    typedef struct BruteRelMagicWorkspace BruteRelMagicWorkspace;
    BruteRelMagicWorkspace* workspace = (BruteRelMagicWorkspace*)malloc(sizeof(BruteRelMagicWorkspace));
    const uint32_t cbrt_magic = find_magic_rel_error(1.0f / 3.0f, workspace);
    free((void*)workspace);

    printf("0x%x\n", cbrt_magic);
}
```


#### `find_magic_rel_error_fast`

 * Faster variant, approximates where the max pos/neg err would be located.
 * Is liable to be off by a few values (in practice the difference is ~1e-7).
 * Often around 5 orders of magnitude faster than the other method.

Example usage:
```c
#include <stdio.h>
#include <approx_root/find_magic_rel.h>

void calculate_cbrt() {
    const uint32_t cbrt_magic = find_magic_rel_error_fast(1.0f / 3.0f);
    printf("0x%x\n", cbrt_magic);
}
```

### Lowest ULP Error

For calculating the lowest ULP error `abs(asuint(correct) - asuint(approx))`, there is just the one function.

#### `find_magic_ulp_error`

Example usage:
```c
#include <stdio.h>
#include <approx_root/find_magic_ulp.h>

void calculate_cbrt() {
    const uint32_t cbrt_magic = find_magic_ulp_error(1.0f / 3.0f);
    printf("0x%x\n", cbrt_magic);
}
```

### Toy Commandline Example

Expects a single argument `root`.

```c
    #include <stdio.h>
    #include <stdlib.h>
    #include <approx_root/find_magic_rel.h>
    #include <approx_root/find_magic_ulp.h>

    int main(int argc, char* argv[]) {

        if (argc != 2) {
            printf("Expected a single argument, `root`\n");
            return -1;
        }

        const float root = atof(argv[1]);
        if (root <= 1.0) {
            printf("Root should be greater than 1, root=%f\n", root);
            return -2;
        }

        const float iroot = 1.0f / root;

        typedef struct BruteRelMagicWorkspace BruteRelMagicWorkspace;
        BruteRelMagicWorkspace* workspace = (BruteRelMagicWorkspace*)malloc(sizeof(BruteRelMagicWorkspace));
        const uint32_t magic_relerr = find_magic_rel_error(iroot, workspace);
        const uint32_t magic_relerr_fast = find_magic_rel_error_fast(iroot);
        const uint32_t magic_ulperr = find_magic_ulp_error(iroot);
        free((void*)workspace);

        printf("Least Rel Err       : 0x%x\n", magic_relerr);
        printf("Least Rel Err (fast): 0x%x\n", magic_relerr_fast);
        printf("Least ULP Err       : 0x%x\n", magic_ulperr);
        return 0;
    }
```
