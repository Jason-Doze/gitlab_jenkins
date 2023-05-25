#!/bin/bash

# This script checks if Emacs is installed, and if not, it installs Emacs on the system by using the apt package manager.

# Install Emacs
if ( which emacs > /dev/null )
then 
  echo -e "\n\033[1;32m==== Emacs installed ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Installing Emacs ====\033[0m\n"
  sudo apt install -y emacs
  sudo apt remove emacs emacs-gui
fi


