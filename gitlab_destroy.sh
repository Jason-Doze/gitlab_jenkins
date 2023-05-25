#!/bin/bash

# Uninstall GitLab
if ( which gitlab-ctl > /dev/null ) 
then
  echo -e "\n\033[1;33m==== Uninstalling GitLab ====\033[0m\n"  
  sudo systemctl stop gitlab-runsvdir.service
  sudo systemctl disable gitlab-runsvdir.service
  systemctl status gitlab-runsvdir.service
  sudo apt remove --purge -y gitlab-ee
  sudo apt clean
  sudo apt autoremove -y  
else
  echo -e "\n\033[1;32m==== GitLab is not installed ====\033[0m\n"
fi
