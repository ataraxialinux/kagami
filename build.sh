#!/bin/sh

VERSION=20190622

set -e

echo "Compiling kagami package manager version $VERSION"

rm -rf kagami vercmp

echo "Compiling scripts"
for scripts in kagami; do
	cp $scripts.in $scripts
	sed -i $scripts -e "s|@VERSION[@]|$VERSION|g"
done

echo "Compiling helpers"
${CROSS_COMPILE}cc $CFLAGS -static helpers/strlcpy.c helpers/vercmp.c helpers/dewey.c -o vercmp >&2

echo "Done!"

exit 0

