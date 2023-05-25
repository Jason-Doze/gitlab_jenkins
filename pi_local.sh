#!/bin/bash

# This script will log in the address of a raspberry-pi 400 ubuntu server, copy the files over the Pi, excute the script, and SSH into the server.

echo -e "\n==== Validate Pi server is running ====\n"
while true
do
  if (  ssh -T -o StrictHostKeyChecking=no "$USER@$PI_HOST" 'exit' 2>/dev/null )
  then
    echo -e "\n==== Server is running  ====\n"
    break
  else
    printf "\033[31m.\033[0m"
    sleep 5
  fi
done

# Use Rsync to copy files to the Pi server
echo -e "\n\033[1;32m==== Copying files to Pi ====\033[0m\n"

rsync -av -e "ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_ed25519" --delete --exclude={'pi_local.sh','gitlab_vmdeploy.sh','jenkins_vmdeploy.sh','.git','.gitignore','commands.txt','README.md'} "$(pwd)" "$USER@$PI_HOST:/home/$USER"

# Use SSH to execute commands on the remote VM
echo -e "\n\033[1;32m==== Executing install script ====\033[0m\n"
ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_ed25519 "$USER"@$PI_HOST 'cd relativepath_leveltwo && bash gitlab_install.sh && bash emacs_install.sh'

# SSH into Pi server
echo -e "\n\033[1;32m==== SSH into Pi ====\033[0m\n"
ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_ed25519 "$USER"@$PI_HOST
