#!/bin/sh

VERSION=20190622

set -e

die() {
	echo -e "ERROR: $@"
	exit 1
}

build_src() {
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
}

install_src() {
	install -Dvm775 kagami "${DESTDIR}"${PREFIX}/bin/kagami
	install -Dvm775 vercmp "${DESTDIR}"${PREFIX}/bin/vercmp
}

DESTDIR=
PREFIX=/usr/local

while getopts :ibpd: options; do
	case $options in
		b)
			mode=build
			;;
		i)
			mode=install
			;;
		p)
			PREFIX="${OPTARG}"
			;;
		d)
			DESTDIR="${OPTARG}"
			;;
		:)
			die "Option '-${OPTARG}' needs an argument"
			;;
		\?)
			die "Option '-${OPTARG}' is illegal"
			;;
	esac
done
if [ "$#" -eq 0 ]; then
	die "Specify options. To list available options use: kagami -h"
fi
shift $((OPTIND - 1))

case $mode in
	build)
		build_src
		;;
	install)
		install_src
		;;
esac

exit 0

