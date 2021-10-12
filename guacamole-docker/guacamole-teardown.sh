#!/bin/sh

# Configure Docker client to use the local host
eval $(docker-machine env --unset)

# Delete docker remote host
docker-machine rm guacamole-host
