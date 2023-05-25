# GitLab | Jenkins | Emacs installation with Multipass or Raspberry Pi on macOS

## This repository provides scripts and instructions for automating the installation and uninstallation of GitLab, Jenkins, and Emacs on Multipass virtual machines or Raspberry Pi 400 running Ubuntu, specifically for macOS users.

## Setup
Clone the GitLab installation repository:

```bash
git clone https://github.com/Jason-Doze/gitlab_jenkins.git
```

## Virtual Machine Stucture:
1. `vm_deploy.sh`: This script automates the installation of GitLab-Jenkins scripts on a Multipass VM from MacOS, including the installation of dependencies, setting up the VM, transferring files, executing install scripts, and SSH into the VM.
2. To execute any desired install or uninstall scripts on the remote VM, add `bash filename.sh` after the && operator in the following command:
```bash
ssh -o StrictHostKeyChecking=no -i ./id_ed25519 "$USER@$(multipass info relativepath | grep IPv4 | awk '{ print $2 }')" 'cd gitlab_jenkins && bash filename.sh'
```
3. Replace filename.sh with the actual filename of install or uninstall script.
4. `vm_destroy.sh`: This script terminates the VM, removes the VM's fingerprint from known hosts, deletes SSH keys, and removes the cloud-init.yaml file associated with the VM.
* To run the VM deployment, use the command:
```shell
bash vm_deploy.sh
```
* To run the VM destroy, log out of the VM by typing `exit` then use the command:
```shell
bash vm_destoy.sh
```

## Pi Server Structure:
1. `pi_local.sh`: This script validates the running status of a Raspberry Pi 400 Ubuntu server, copies files to the Pi, executes an install script, and SSH into the server.
2. To execute any desired install or uninstall scripts on the Pi server, add `bash filename.sh` after the && operator in the following command:
```bash
ssh -o StrictHostKeyChecking=no $USER@$PI_HOST 'cd gitlab_jenkins && bash filename.sh'
```
3. Replace filename.sh with the actual filename of install or uninstall script.
* To run the Pi deployment, use the command:
```bash
PI_HOST=$(dig +short pi | tail -n1) bash pi_local.sh
```


## Install / Uninstall scripts:
1. `emacs_install.sh`: This script checks if Emacs is installed, and if not, it installs Emacs on the system by using the apt package manager.
2. `emacs_uninstall.sh`: This script checks if Emacs is installed, and if so, it removes Emacs from the system using the apt package manager.
3. `gitlab_install.sh`: This script updates the system, installs GitLab on Ubuntu by installing and configuring dependencies, adding the GitLab package repository, and installing the GitLab-EE package, and displays the IP address and initial root password for accessing GitLab.
4. `gitlab_uninstall.sh`: This script checks if GitLab is installed, and if so, it removes GitLab from the system by stopping the necessary service, disabling the service, and purging the GitLab-EE package. Additionally, it performs a cleanup by removing unnecessary packages and dependencies.
5. `jenkins_install.sh`: This script updates the system, installs Java (OpenJDK 11), and then installs Jenkins on Ubuntu by adding the Jenkins repository key, adding the Jenkins repository to the package sources, and installing the Jenkins package. It also displays the IP address and initial admin password for accessing Jenkins.
6. `jenkins_uninstall.sh`: This script checks if Java (OpenJDK 11) and Jenkins are installed. If they are present, it removes Java and Jenkins from the system by purging the packages, removing the Jenkins data directory, and performs a clean up by removing unnecessary packages and dependencies.

