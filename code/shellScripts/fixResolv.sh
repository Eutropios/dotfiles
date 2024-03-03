#!/usr/bin/env sh

sudo unlink /etc/resolv.conf # this will unlink the default wsl2 resolv.conf

# This config will prevent wsl2 from overwritting the resolve.conf file everytime
# you start wsl2
cat <<EOF | sudo tee -a /etc/wsl.conf
[network]
generateResolvConf = false
EOF

cat <<EOF | sudo tee -a /etc/resolv.conf
nameserver 192.168.1.254
nameserver 1.1.1.1
nameserver 1.0.0.1
EOF

# Make the new /etc/resolve.conf immutable
sudo chattr +i /etc/resolv.conf
