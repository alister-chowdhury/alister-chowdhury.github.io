import numpy
import os
from PIL import Image


def make_vis_images(span, sigmas):
    """Generate numpy images to represent different sigma falloffs.

    Args:
        span (int): Span of image (will be 2*span-1 width and height).
        sigmas (iterable[float]): Sigmas to make.

    Yields:
        PIL.Image: Per sigma image.
    """
    distsq = numpy.array([
        [
            (x**2 + y**2)
            for x in range(-span, span + 1)
        ]
        for y in range(-span, span + 1)
    ])
    for sigma in sigmas:
        yield Image.fromarray(
            (numpy.exp(-distsq * sigma**-2) * 255).astype(numpy.uint8)
        )


if __name__ == "__main__":
    sigmas = numpy.linspace(1, 3, 11)
    span = 8
    for sigma, image in zip(sigmas, make_vis_images(span, sigmas)):
        image.save(
            os.path.abspath(
                os.path.join(
                    __file__,
                    "..",
                    "sigma{0}.png".format(sigma.round(1))
                )
            )
        )
