. ./guacamole-variables.sh
ansible-playbook -v ./ansible-guac-teardown.yml
ssh-keygen -f $HOME/.ssh/known_hosts -R 52.15.140.244
