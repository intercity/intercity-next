#!/bin/sh

grep -q "swapfile" /etc/fstab

if [ $? -eq 0 ]; then
  echo 'swapfile found. Removing swapfile.'
  sed -i '/swapfile/d' /etc/fstab
  echo "3" > /proc/sys/vm/drop_caches
  swapoff -a
  rm -f /swapfile
else
  echo 'No swapfile found. No changes made.'
fi
