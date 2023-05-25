# GitLab Installation with Multipass on macOS
This bash automation script installs GitLab on a Virtual Machine using Multipass on macOS.

## Setup
Clone the GitLab installation repository:

```bash
git clone https://github.com/Jason-Doze/<repository>.git
```

Run the vm_deploy.sh script:

```shell
bash gitlab_vmdeploy.sh
```

The gitlab_vmdeploy.sh script performs the following actions:

* Installs Homebrew
* Installs Multipass
* Installs Rsync
* Generates an SSH key pair
* Creates a cloud-init.yaml file
* Launches a Multipass instance named "relativepath"
* Transfers files to the VM using Rsync
* Runs gitlab_install.sh on the VM

The gitlab_install.sh script performs the following actions:

* Updates the system packages
* Installs GitLab dependencies
* Configures Postfix for GitLab
* Installs GitLab using the GitLab package repository
* Displays IP address on the console to access GitLab.

Run the vm_destroy.sh script:

```shell
bash vm_destroy.sh
```

The vm_destroy.sh script performs the following actions:

* Deletes the Multipass instance
* Deletes the SSH key pair
* Deletes the fingerprint from the known host file

## Usage
From your local system (macOS), use the following command to run the `pi_local.sh` script:

```bash
PI_HOST=$(dig +short pi | tail -n1) bash pi_local.sh
```