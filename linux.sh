#!/bin/sh

VERSION=5.18.7

if test -f "./linux.tar.xz"; then
	tar -xvf linux.tar.xz
	mv linux-${VERSION} linux
else
	wget https://mirrors.edge.kernel.org/pub/linux/kernel/v${VERSION%%.*}.x/linux-$VERSION.tar.xz -O linux.tar.xz
	tar -xvf linux.tar.xz
	mv linux-${VERSION} linux
fi

cd linux || exit

	make defconfig
	sed -i "s/.*CONFIG_DEFAULT_HOSTNAME.*/CONFIG_DEFAULT_HOSTNAME=\"ToastLinux\"/" .config

	sed -i "s/.*CONFIG_OVERLAY_FS.*/CONFIG_OVERLAY_FS=y/" .config
	echo "# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set" >> .config
	echo "# CONFIG_OVERLAY_FS_INDEX is not set" >> .config
	echo "CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y" >> .config
	echo "# CONFIG_OVERLAY_FS_NFS_EXPORT is not set" >> .config
	echo "# CONFIG_OVERLAY_FS_XINO_AUTO is not set" >> .config
	echo "# CONFIG_OVERLAY_FS_METACOPY is not set" >> .config

	sed -i "s/.*CONFIG_FB_VESA.*/CONFIG_FB_VESA=y/" .config
	sed -i "s/^CONFIG_DEBUG_KERNEL.*/\\# CONFIG_DEBUG_KERNEL is not set/" .config
	sed -i "s/.*CONFIG_EFI_STUB.*/CONFIG_EFI_STUB=y/" .config

	echo "CONFIG_RESET_ATTACK_MITIGATION=y" >> .config
	echo "CONFIG_APPLE_PROPERTIES=n" >> .config

	if [ "`grep "CONFIG_X86_64=y" .config`" = "CONFIG_X86_64=y" ] ; then
		echo "CONFIG_EFI_MIXED=y" >> .config
	fi

	make bzImage
	cp arch/x86_64/boot/bzImage ../kernel

cd .. || exit
