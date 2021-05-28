#!/bin/bash
# See https://discourse.nixos.org/t/building-with-cuda-on-nixpkgs/4462/14

# A script that creates symlinks
sudo tee /usr/local/bin/nix-symlink-gpu <<EOF
#! /bin/sh
mkdir -p /run/opengl-driver/lib/
rm /run/opengl-driver/lib/*
ln -sf /usr/lib/x86_64-linux-gnu/libcuda* /run/opengl-driver/lib/
ln -sf /usr/lib/x86_64-linux-gnu/libnvidia-* /run/opengl-driver/lib/
EOF
sudo chmod a+x /usr/local/bin/nix-symlink-gpu

# A systemd unit that runs the script at startup
sudo tee /etc/systemd/system/nix-symlink-gpu.service <<EOF
[Unit]
Description=Symlink GPU drivers for use by software packaged with Nix

[Service]
Type=oneshot
ExecStart=/usr/local/bin/nix-symlink-gpu

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable --now nix-symlink-gpu.service
