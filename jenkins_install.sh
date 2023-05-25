#!/bin/bash

# This script updates the system, installs Java (OpenJDK 11), and then installs Jenkins on Ubuntu by adding the Jenkins repository key, adding the Jenkins repository to the package sources, and installing the Jenkins package. It also displays the IP address and initial admin password for accessing Jenkins.

sudo apt update

# Install Java 
if ( dpkg -l openjdk-11-jre > /dev/null )
then
  echo -e "\n\033[1;32m==== Java installed ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Installing Java ====\033[0m\n"
  sudo apt update
  sudo apt install -y openjdk-11-jre
fi

# Install Jenkins
if ( which jenkins > /dev/null )
then
  echo -e "\n\033[1;32m==== Jenkins installed ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Installing Jenkins ====\033[0m\n"
  curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
  echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
  sudo apt update
  sudo apt install -y jenkins
fi

echo -e "\n\033[1m \033[32mIP Address:\033[0m \033[37m$(hostname -I | awk '{print $1}') \033[0m\n"

echo -e "\n\033[1m \033[32mPassword:\033[0m \033[37m$( sudo cat /var/lib/jenkins/secrets/initialAdminPassword ) \033[0m\n"

