## Guacamole


### Files in this repo

`guac-setup.sh` - setup script setting up the Guacamole VPC, student VMs, and server in AWS

`guac-teardown.sh` - teardown script for deleting all Guacamole hosts in AWS

`guac-vpc-setup.sh` - setup script setting up a Guacamole VPC, subnets, security groups, in AWS

`guac-vpc-teardown.sh` - teardown script for deleting all Guacamole VPCs in AWS

`guac-vm-setup.sh` - setup script setting up a Guacamole student VMs in the Guacamole VPC (in its private subnet)

`guac-vm-teardown.sh` - teardown script for deleting all VMs under the Guacamole VPC's private subnet (including student VMs)

`guac-server-setup.sh` - setup script setting up a Guacamole server in the Guacamole VPC (in its public subnet) and
redirects `lab.rx-m.com/guacamole` to the Guacamole UI

`guac-server-teardown.sh` - teardown script for deleting the Guacamole server in AWS

`guacamole-variables.sh` - variables that feed the setup script



### Setup

The `guac-setup.sh` script will stand up a docker-based Guacamole gateway. It installs `docker`, `docker-machine` and
`docker-compose` on a local VM, uses variables from `guacamole-variables.sh` to spin up an AWS instance, copies up the
MySQL script in the `config/` subdirectory to bootstrap the Guacamole database and deploys 3 containers to provide the
Guacamole gateway.

Steps:

1. Clone the repo

2. Download the pre-made certificates (Expires 2021 Sept 9) from the prod S3 (Under /rx-m-guacamole/guaccerts.zip)
and extract all of the contents to `/courseware-dev-guide/guacamole-docker/ansible/ssl/`

3. Edit `guacamole-variables.sh` and update the following variables:

- `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` to change the credentials
- `STUDENT_VM_COUNT` to determine how many Student VMs to spin up (default = 1)
- `STUDENT_VM_TYPE` to determine the instance types (default=t2.medium)

Always spin up 1 more student VM than you have students in case you need to test something or you have a walk-in. If you
need additional student VMs on the fly, create one under the guac-private security group and manually assign it to one
of the student accounts on guac (student01-student25).

4. Run the `guac-setup.sh` script from inside its containing folder to stand up the VPC, student VMs and Guacamole Server

On some systems, we observed that sometimes the PATH is not updated to include the local Ansible install path. If you
get a message that `ansible` is not avaiable on the machine after running the script, run the following command:

`export PATH=$PATH:$HOME/.local/bin`.

Scripts are available to run the VPC, Student VM, and Guac separately. `guac-vpc-setup.sh` must always be run first.


###. Change user passwords

The default passwords for all of the accounts are currently `ubuntu`. If needed, change the passwords by following the
steps below:

Log into Guacamole at http://lab.rx-m.net/guacamole/. The admin credentials are `guacadmin/ubuntu` and should also be
changed after first login!

Navigate to the "guacadmin" menu in the top right corner and select "Settings".

On the Settings page, select "Users" from the tabs along the top left. There will be 25 users named studentXX.

Click on "student01".
- Under Edit User, update the password
- Scroll to the bottom of the page and click "Save"

Repeat the above steps for the number of lab users. Unused Users _do not_ need to be deleted and can safely be ignored.


### Teardown

Teardown is accomplished with the `guac-teardown.sh` script, which will tear down the Guacamole server, Student VMs, and
the Guacamole VPC.


### Certificate Generation

If you need to generate Certs for Guacamole, run the following steps:

SSH to Guac Server and stop the `guacamole` container:

```
user@ubuntu:~$ ssh -i .ssh/guacamole-host.pem ubuntu@lab.rx-m.net

ubuntu@lab.rx-m.net:~$ sudo docker stop guacamole
```

Next, use certbot to create a new set of certs for lab.rx-m.net using info@rx-m.com as the notification email.

```
ubuntu@lab.rx-m.net:~$ sudo docker container run -it --rm -p 443:443 -p 80:80 --name certbot \
-v /etc/letsencrypt:/etc/letsencrypt \
-v /var/lib/letsencrypt:/var/lib/letsencrypt \
-v /var/log/letsencrypt:/var/log/letsencrypt \
certbot/dns-route53 certonly --standalone
```

This creates the certs under `/etc/letsencrypt/archive/lab.rx-m.net/`. Copy them to the home directory:

```
ubuntu@lab.rx-m.net:~$ sudo cp /etc/letsencrypt/archive/lab.rx-m.net/*.pem
```

Once the certs are created and moved, use `scp` to retrieve the certs from the lab.rx-m.com machine to your local VM:

```
ubuntu@labsys:~$ scp -i ~/.ssh/guacamole-host.pem ubuntu@lab.rx-m.net:/home/ubuntu/ssl/certs/*.pem /courseware-dev-guide/guacamole-docker/ansible/ssl/
```
