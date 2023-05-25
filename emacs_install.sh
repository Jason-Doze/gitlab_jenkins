#!/bin/bash

if ( which emacs > /dev/null )
then 
  echo -e "\n\033[1;32m==== Emacs installed ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Installing Emacs ====\033[0m\n"
  sudo apt install -y emacs
  sudo apt remove emacs emacs-gui
fi


