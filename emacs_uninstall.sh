#!/bin/bash

# This script checks if Emacs is installed, and if so, it removes Emacs from the system using the apt package manager.

# Remove Emacs
if ( which emacs > /dev/null )
then 
  echo -e "\n\033[1;32m==== Removing Emacs ====\033[0m\n"
  sudo apt remove -y emacs
  sudo apt autoremove -y
else
  echo -e "\n\033[1;33m==== Emacs not present ====\033[0m\n"
fi