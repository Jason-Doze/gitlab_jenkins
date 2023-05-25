#!/bin/bash

# This script checks if Java (OpenJDK 11) and Jenkins are installed. If they are present, it removes Java and Jenkins from the system by purging the packages, removing the Jenkins data directory, and performs a clean up by removing unnecessary packages and dependencies.

# Remove Java 
if ( dpkg -l openjdk-11-jre > /dev/null )
then
  echo -e "\n\033[1;32m==== Removing Java ====\033[0m\n"
  sudo apt remove --purge -y openjdk-11-jre
  sudo apt autoremove -y
else
  echo -e "\n\033[1;33m==== Java not present ====\033[0m\n"
fi

# Remove Jenkins
if ( which jenkins > /dev/null )
then
  echo -e "\n\033[1;32m==== Removing Jenkins ====\033[0m\n"
  sudo apt remove --purge -y jenkins
  sudo rm -r /var/lib/jenkins
  sudo apt autoremove -y
else
  echo -e "\n\033[1;33m==== Jenkins not present ====\033[0m\n"
fi