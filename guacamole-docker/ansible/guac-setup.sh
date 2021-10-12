#!/bin/sh

# Update indexes
#
# Update the apt package indexes to ensure the latest packages are installed.

sudo apt update


# Install System Packages
#
# Ansible is a Python module so we need to install the Python pip package
# manager. Ansible depends on ssl and cffi headers so we have to install these
# as well. The ssl lib may not register in time for the ansible build, running
# ldconfig here forces the libs to be added to the cache immediately.

sudo apt install -y python3-pip=8.1.1-2ubuntu0.4 libssl-dev libffi-dev jq
sudo ldconfig


# Install Python Modules
#
# Pip install ansible

pip3 install --upgrade --user ansible==2.7.6
export PATH=$PATH:$HOME/.local/bin

# Environment Setup
#
# Create environment variables with keys and passwords

. ./guacamole-variables.sh


# Install Ansible config files
#
# Copy Ansible config files to /etc/ansible

sudo ln -s /usr/bin/python3 /usr/bin/python
sudo mkdir -p /etc/ansible
sudo chmod 755 /etc/ansible
sudo cp ./ansible.cfg /etc/ansible/
sudo cp ./ec2.ini /etc/ansible/
sudo cp ./ec2.py /etc/ansible/hosts
sudo chmod +x /etc/ansible/hosts


# Standup Guacamole Server
#
# Run the ansible-ci-setup.yml playbook to provision and configure the
# Guacamole server.
# TODO: Switch to Councourse and mirror/mod this to ansible-concourse/

ansible-playbook -v ./ansible-guac-vpc-setup.yml
./guac-student-vm-setup.sh
ansible-playbook -v ./ansible-guac-setup.yml
