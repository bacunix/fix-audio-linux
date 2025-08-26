#!/bin/bash

# Chỉ chạy một lần duy nhất
if [ -f /tmp/audio_fixed ]; then
    exit 0
fi

# Thực hiện các lệnh sửa audio
lspci | grep -i audio > /dev/null 2>&1
lspci -nn | grep 8086:9d77 > /dev/null 2>&1

echo 1 | sudo tee /sys/bus/pci/devices/0000:00:1f.3/remove > /dev/null 2>&1
echo 1 | sudo tee /sys/bus/pci/rescan > /dev/null 2>&1
sudo setpci -s 00:1f.3 COMMAND=0x02 > /dev/null 2>&1

lspci -v -s 00:1f.3 | grep -i memory > /dev/null 2>&1

sudo modprobe snd_hda_intel > /dev/null 2>&1

echo "snd_hda_intel" | sudo tee /sys/bus/pci/devices/0000:00:1f.3/driver_override > /dev/null 2>&1
echo 0000:00:1f.3 | sudo tee /sys/bus/pci/drivers/snd_hda_intel/bind > /dev/null 2>&1

ls -la /sys/bus/pci/devices/0000:00:1f.3/driver > /dev/null 2>&1
sudo dmesg | tail -10 > /dev/null 2>&1
aplay -l > /dev/null 2>&1

# Đánh dấu đã chạy
touch /tmp/audio_fixed
