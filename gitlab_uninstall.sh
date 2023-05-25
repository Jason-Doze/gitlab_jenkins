#!/bin/bash

# This script checks if GitLab is installed, and if so, it removes GitLab from the system by stopping the necessary service, disabling the service, and purging the GitLab-EE package. Additionally, it performs a cleanup by removing unnecessary packages and dependencies.

# Remove Gitlab
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
  echo -e "\n\033[1;32m==== GitLab not present ====\033[0m\n"
fi
