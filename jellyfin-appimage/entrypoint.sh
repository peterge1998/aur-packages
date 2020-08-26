#!/bin/sh -l
set -x

#pacman -Sy git --noconfirm

sudo -u devel bash -c 'cd ~ && 
git clone https://github.com/peterge1998/aur-packages/ && \
git clone https://aur.archlinux.org/jellyamp-appimage.git && \

cd aur-packages/jellyfin-appimage/ && \

yes | cp -rf PKGBUILD.template PKGBUILD && \

# set pkgver
sed -i "s/package-version/$(curl -s https://api.github.com/repos/m0ngr31/jellyamp/releases/latest | grep tag_name | cut -d \" -f 4 | tr -d "v")/g" PKGBUILD && \

# increase pkgrel
pkgrel=$(($(grep pkgrel ~/jellyamp-appimage/PKGBUILD | cut -d \= -f 2) + 1)) && \
sed -i "s/package-release/$pkgrel/g" PKGBUILD && \

makepkg -g >> PKGBUILD && \
makepkg --printsrcinfo > .SRCINFO && \

echo "::set-output name=time::$time"'

cp /home/devel/aur-packages/jellyfin-appimage/.SRCINFO /github/workspace/jellyfin-appimage/.SRCINFO
cp /home/devel/aur-packages/jellyfin-appimage/PKGBUILD /github/workspace/jellyfin-appimage/PKGBUILD
