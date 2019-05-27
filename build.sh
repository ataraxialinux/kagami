#!/bin/sh

set -e

# print logo

echo "Cleaning up..."
rm -rf vercmp hakai minaoshi tsukuri

echo "Generating scripts"
for scripts in hakai minaoshi tsukuri; do
	cp $scripts.in $scripts
	sed -i $scripts -e "s|@VERSION[@]|$VERSION|g"
done

echo "Compiling helpers"
${CROSS_COMPILE}cc $CFLAGS -static helpers/strlcpy.c helpers/vercmp.c helpers/dewey.c -o vercmp >&2

echo "Done!"

exit 0

