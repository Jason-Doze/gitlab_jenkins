#!/bin/env bash

if ( getent group "$USER" | grep lxd )
then
    echo "User already in lxd group"
else
    sudo -E usermod -aG "$USER" lxd
    sudo lxd init --minimal
fi

if [ -s id_ed25519.pub ]
then
    echo "SSH keys already exist"
else
    ssh-keygen -t ed25519 -q -C "$USER@relativepath.tech" -N "" -f "./id_ed25519"
fi

if ( grep "$(cat id_ed25519.pub)" user-data )
then
    echo "user-data already exists"
else
    cat <<- EOF > user-data
#cloud-config
users:
  - default
  - name: ${USER}
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - $(cat ./id_ed25519.pub)
EOF
fi

if ( sudo lxc info rp-vm-01 )
then
    echo "rp-vm-01 already running"
else
    sudo lxc launch ubuntu:22.04 rp-vm-01 --vm --config=user.user-data="$(cat user-data)"
fi

# watch sudo lxc list rp-vm-01

ssh -i id_ed25519 "$USER@$(sudo lxc list rp-vm-01 -c 4 -f csv | awk '{ print $1 }')"

# sudo lxc stop rp-vm-01 && sudo lxc delete rp-vm-01