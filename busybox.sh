#!/bin/sh

VERSION=1.35.0

if test -f "./busybox.tar.bz2"; then
	tar -xvf busybox.tar.bz2
	mv busybox-${VERSION} busybox
else
	wget https://busybox.net/downloads/busybox-${VERSION}.tar.bz2 -O busybox.tar.bz2
	tar -xvf busybox.tar.bz2
	mv busybox-${VERSION} busybox
fi

cd busybox || exit
	make defconfig
	sed -i "s/.*CONFIG_STATIC.*/CONFIG_STATIC=y/" .config
	# first time make will abort forced y
	yes | make busybox
	yes | make oldconfig
	# now make won't abort forced y
	yes | make busybox
	make install
cd .. || exit
