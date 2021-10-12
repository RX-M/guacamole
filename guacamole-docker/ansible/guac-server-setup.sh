#!/bin/sh

# Environment Setup
#
# Create environment variables with keys and passwords

. ./guacamole-variables.sh

# Standup Guacamole Server
#
# Run the ansible-ci-setup.yml playbook to provision and configure the
# Guacamole server.
# TODO: Switch to Councourse and mirror/mod this to ansible-concourse/

ansible-playbook -v ./ansible-guac-setup.yml
