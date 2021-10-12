#!/bin/sh

# Update indexes and install docker-ce version 19.03.8
sudo apt-get update
sudo apt-get -y install apt-transport-https ca-certificates curl
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get -y install docker-ce=5:19.03.8~3-0~ubuntu-xenial
sudo usermod -aG docker user

# Install Docker Machine version 0.16.2 and Compose version 1.25.4
if [ -f "/usr/local/bin/docker-machine" ]; then
  echo "Docker Machine already installed"
else
  sudo curl -L https://github.com/docker/machine/releases/download/v0.16.2/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
  chmod +x /tmp/docker-machine &&
  sudo cp /tmp/docker-machine /usr/local/bin/docker-machine
fi

if [ -f "/usr/local/bin/docker-compose" ]; then
  echo "Docker Compose already installed"
else
  sudo curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` >/tmp/docker-compose &&
  chmod +x /tmp/docker-compose &&
  sudo cp /tmp/docker-compose /usr/local/bin/docker-compose
fi

# Create environment variables
. ./guacamole-variables.sh

# Use Docker Machine to set up remote host
docker-machine create \
--driver amazonec2 \
--amazonec2-access-key $AWS_ACCESS_KEY_ID \
--amazonec2-secret-key $AWS_SECRET_ACCESS_KEY \
--amazonec2-ami $AWS_AMI \
--amazonec2-instance-type $AWS_INSTANCE_TYPE \
--amazonec2-region $AWS_DEFAULT_REGION \
--amazonec2-ssh-user $AWS_SSH_USER \
--amazonec2-subnet-id $AWS_SUBNET_ID \
--amazonec2-zone $AWS_ZONE \
--amazonec2-vpc-id $AWS_VPC_ID \
guacamole-host

# Copy Guacamole database file to remote host
docker-machine scp -r ./config/ guacamole-host:/home/ubuntu/guacamole/

# Configure Docker client to use the remote host
eval $(docker-machine env guacamole-host)

# Deploy Guacamole containers
docker-compose up -d
