#!/bin/sh

total_mem=`cat /proc/meminfo | grep MemTotal | awk '{ print $2 }'`
swapsize=$((total_mem / 1024 * 3))

grep -q "swapfile" /etc/fstab

if [ $? -ne 0 ]; then
  echo 'swapfile not found. Adding swapfile.'
  fallocate -l ${swapsize}M /swapfile
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo '/swapfile none swap defaults 0 0' >> /etc/fstab
else
  echo 'swapfile found. No changes made.'
fi
