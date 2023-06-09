#!/bin/bash

# This script automates the installation of GitLab-Jenkins scripts on a Multipass VM from MacOS, including the installation of dependencies, setting up the VM, transferring files, executing install scripts, and SSH into the VM.

# Install homebrew
if ( which brew > /dev/null )
then 
  echo -e "\n\033[1;32m==== Brew installed ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Installing brew ====\033[0m\n"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Rsync
if ( which rsync > /dev/null)
then 
  echo -e "\n\033[1;32m==== Rsync installed ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Installing Rsync ====\033[0m\n"
fi

# Install Multipass
if ( which multipass > /dev/null )
then 
  echo -e "\n\033[1;32m==== Multipass installed ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Installing Multipass ====\033[0m\n"
  brew install --cask multipass
fi

# Set Multipass local driver to Qemu
if [ "$(multipass get local.driver)" = "qemu" ]
then
  echo -e "\n\033[1;32m==== Qemu local driver set ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Setting Qemu as Multipass local driver ====\033[0m\n"
  multipass set local.driver=qemu
fi

# Create an SSH key pair
if [ -f id_ed25519 ]
then  
  echo -e "\n\033[1;32m==== SSH key present  ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Creating SSH key pair ====\033[0m\n"
  ssh-keygen -t ed25519 -N '' -f ./id_ed25519
fi

# Write out cloud-init.yaml
if [ -f cloud-init.yaml ]
then 
  echo -e "\n\033[1;32m==== Cloud-init.yaml present  ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Writing cloud-init.yaml ====\033[0m\n"
  cat <<- EOF > cloud-init.yaml
users:
  - default
  - name: $USER
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - $(cat id_ed25519.pub)
EOF
fi

# Launch relativepath instance
if ( multipass list | grep relativepath | grep Running > /dev/null )
then 
  echo -e "\n\033[1;32m==== Relativepath VM present ====\033[0m\n"
else 
  echo -e "\n\033[1;33m==== Creating relativepath VM ====\033[0m\n"
  multipass launch --cpus 4 --memory 7G --disk 50G --name relativepath --cloud-init cloud-init.yaml
fi

echo -e "\n\033[1;32m==== Transferring files to VM ====\033[0m\n"
rsync -av -e "ssh -o StrictHostKeyChecking=no -i ./id_ed25519" --delete --exclude={'id_ed25519','id_ed25519.pub','cloud-init.yaml'} "$(pwd)" "relativepath@$(multipass info relativepath | grep IPv4 | awk '{ print $2 }'):/home/$USER" 

# Use SSH to execute commands on the remote VM
echo -e "\n\033[1;32m==== Execute install scripts on VM ====\033[0m\n"
ssh -o StrictHostKeyChecking=no -i ./id_ed25519 "$USER@$(multipass info relativepath | grep IPv4 | awk '{ print $2 }') 'cd gitlab_jenkins && bash gitlab_install.sh'"

# SSH into VM
echo -e "\n\033[1;32m==== SSH into VM ====\033[0m\n"
ssh -o StrictHostKeyChecking=no -i ./id_ed25519 "$USER@$(multipass info relativepath | grep IPv4 | awk '{ print $2 }')"