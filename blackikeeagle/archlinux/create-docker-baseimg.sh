#!/bin/bash
(( EUID != 0 )) && echo 'This script must be run as root.' && exit 1
set -e

buildfolder=$(basename $0)-$RANDOM

mkdir -p "$buildfolder"

pacstrap -C ./mkimage-arch-pacman.conf -c -G -M -d "$buildfolder" \
    filesystem shadow pacman gzip bzip2 sed grep gettext bash procps-ng haveged

# clear packages cache
rm -f "$buildfolder/var/cache/pacman/pkg/"*
rm -f "$buildfolder/var/log/pacman.log"

# create working dev
mknod -m 666 "$buildfolder/dev"/null c 1 3
mknod -m 666 "$buildfolder/dev"/zero c 1 5
mknod -m 666 "$buildfolder/dev"/random c 1 8
mknod -m 666 "$buildfolder/dev"/urandom c 1 9
mkdir -m 755 "$buildfolder/dev"/pts
mkdir -m 1777 "$buildfolder/dev"/shm
mknod -m 666 "$buildfolder/dev"/tty c 5 0
mknod -m 600 "$buildfolder/dev"/console c 5 1
mknod -m 666 "$buildfolder/dev"/tty0 c 4 0
mknod -m 666 "$buildfolder/dev"/full c 1 7
mknod -m 600 "$buildfolder/dev"/initctl p
mknod -m 666 "$buildfolder/dev"/ptmx c 5 2

# link pacman log to /dev/null
arch-chroot "$buildfolder" ln -s /dev/null /var/log/pacman.log

# backup required locale stuff
mkdir store-locale
cp -a "$buildfolder/usr/share/locale/"{locale.alias,en_US} store-locale

# cleanup locale and manpage stuff, not needed to run in container
toClean=('usr/share/locale' 'usr/share/man' 'usr/include')
noExtract='usr/share/locale usr/share/man usr/include'
for clean in ${toClean[@]}; do
    rm -rf "$buildfolder/$clean"/*
    noExtract="$noExtract $clean/*"
done
sed -e "s,^#NoExtract.*,NoExtract = $noExtract !usr/share/locale/en* !usr/share/locale/locale.alias," \
    -i "$buildfolder/etc/pacman.conf"

# restore required locale stuff
cp -a store-locale/* "$buildfolder/usr/share/locale/"
rm -rf store-locale

# generate locales for en_US
sed -e 's/#en_US/en_US/g' -i "$buildfolder/etc/locale.gen"
arch-chroot "$buildfolder" locale-gen

# set default mirror
echo 'Server = http://mirrors.kernel.org/archlinux/$repo/os/$arch' >\
    "$buildfolder/etc/pacman.d/mirrorlist"

# init keyring
arch-chroot "$buildfolder" \
    /bin/sh -c 'haveged -w 2048; \
        pacman-key --init; \
        pacman-key --populate archlinux; \
        pkill haveged; \
        pacman -Rcs --noconfirm haveged;'

imageid=$(tar --exclude=etc/pacman.d/gnupg/S.gpg-agent --numeric-owner --xattrs --acls -C "$buildfolder" -c . | docker import - blackikeeagle/archlinux)
docker tag $imageid blackikeeagle/archlinux:$(date +%Y%m%d)

rm -rf "$buildfolder"
