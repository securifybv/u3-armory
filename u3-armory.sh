#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ISO="$DIR/u3-armory.iso"
ISO_SRC="$DIR/cd"

genisoimage -v -J \
   -V "Cruzer Micro U3" \
   -publisher "Sandisk" \
   -hide '*' \
   -hidden autorun.inf \
   -hidden '*.dll' \
   -hidden '*.local' \
   -o "$ISO" \
   "$ISO_SRC"

echo -e "ci_hdrc_imx\ng_mass_storage" | sudo tee /etc/modules
echo -e "options g_mass_storage file=\"$ISO\" idVendor=0x0781 idProduct=5151 iManufacturer=SanDisk iProduct="Cruzer Micro U3" removable=0 cdrom=1" | sudo tee /etc/modprobe.d/usbarmory.conf

sudo shutdown -h now
