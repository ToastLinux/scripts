#!/bin/sh

git clone https://github.com/ToastLinux/ToastInit.git

mkdir -p rootfs

cp -rvf busybox/_install/* rootfs

rm rootfs/linuxrc

cd rootfs || exit
	for dir in dev etc proc sys tmp; do
		mkdir -p $dir
	done

	cp ../ToastInit/init ./
	cp ../ToastInit/art.txt ./etc/
	chmod +x ./init

	find . | cpio -H newc -o | gzip -9 > ../initrd.img
cd .. || exit
