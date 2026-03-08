#!/bin/bash

#get the pd environment working 
PKG install pd && pd install Ubuntu && pd login Ubuntu

#install aria2
apt install aria2

#install qemu
apt install qemu-utils

# Download Windows XP ISO (includes Supermium + OneCore API)
aria2c -x 16 -s 16 "https://archive.org/download/xp_pro2/xp_pro2.iso" -o xp.iso

# Create disk
qemu-img create -f qcow2 xp.qcow2 20G

# Run VM
qemu-system-x86_64 \
  -m 512 \
    -cpu pentium2 \
      -smp 1 \
        -hda ~/xp.qcow2 \
          -cdrom ~/xp.iso \
            -boot d \
              -vga std \
                -device ne2k_pci,netdev=net0 \
                  -netdev user,id=net0 \
                    -usb \
                      -device usb-tablet \
                        -rtc base=localtime \
                          -display vnc=:1