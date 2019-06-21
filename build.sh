#!/bin/sh

set -e

# print logo

echo "Compiling helpers"
${CROSS_COMPILE}cc $CFLAGS -static helpers/strlcpy.c helpers/vercmp.c helpers/dewey.c -o vercmp >&2

echo "Done!"

exit 0

