#!/usr/bin/env bash

echo "fastestmirror=1" >> /etc/dnf/dnf.conf

powerprofilesctl set performance

dnf upgrade --refresh -y

systemctl daemon-reload

dnf remove qt abrt PackageKit plasma-discover dnfdragora -y

grubby --args="preempt=full" --update-kernel=ALL

dnf rm irqbalance -y

dnf in lm_sensors -y

sensors-detect --auto

echo "compression-algorithm = zstd" >> /usr/lib/systemd/zram-generator.conf

touch /etc/sysctl.d/99-vm-zram-parameters.conf

echo "vm.swappiness = 180" >> /etc/sysctl.d/99-vm-zram-parameters.conf
echo "vm.watermark_boost_factor = 0" >> /etc/sysctl.d/99-vm-zram-parameters.conf
echo "vm.watermark_scale_factor = 125" >> /etc/sysctl.d/99-vm-zram-parameters.conf
echo "vm.page-cluster = 0" >> /etc/sysctl.d/99-vm-zram-parameters.conf

dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

dnf config-manager --enable fedora-cisco-openh264 -y

dnf groupupdate core -y

dnf swap ffmpeg-free ffmpeg --allowerasing -y

dnf groupupdate multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y

dnf groupupdate sound-and-video -y

dnf swap mesa-va-drivers mesa-va-drivers-freeworld -y

dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld -y

dnf swap mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686 -y

dnf swap mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686 -y

dnf in rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted -y

dnf in libdvdcss -y

dnf --repo=rpmfusion-nonfree-tainted install "*-firmware" -y

dnf in libva-utils -y

dnf in wine wine.i686 wine-dxvk wine-dxvk.i686 wine-dxvk-d3d9 wine-dxvk-d3d9.i686 -y

dnf in steam telegram-desktop lutris git -y

dnf install openssl -y

dnf install openssl-libs -y

dnf install GConf2 -y

dnf install openssl1.1 -y

sh -c 'echo -e "[unityhub]\nname=Unity Hub\nbaseurl=https://hub.unity3d.com/linux/repos/rpm/stable\nenabled=1\ngpgcheck=1\ngpgkey=https://hub.unity3d.com/linux/repos/rpm/stable/repodata/repomd.xml.key\nrepo_gpgcheck=1" > /etc/yum.repos.d/unityhub.repo'

dnf check-update -y

dnf install unityhub -y

systemctl reboot

