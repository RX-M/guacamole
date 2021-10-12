## Guacamole


### Files in this repo

`guacamole-host-setup.sh` - setup script setting up a Guacamole host in AWS

`guacamole-teardown.sh` - teardown script for deleting all Guacamole hosts in AWS

`guacamole-variables.sh` - variables that feed the setup script

`docker-compose.yml` - Compose definition of the 3 Guacamole containers, their volumes, networks, etc.

`config/guac_db.sql` - the bootstrap script for seeding the Guacamole DB with Users and Connections

`OLD_guac_db.sql` - the original DB bootstrap script from the Apache project that sets up an empty Guacamole (w/o
pre-made Users and Connections), left here for reference.


### Setup

The `guacamole-host-setup.sh` script will stand up a docker-based Guacamole gateway. It installs `docker`,
`docker-machine` and `docker-compose` on a local VM, uses variables from `guacamole-variables.sh` to spin up an AWS
instance, copies up the MySQL script in the `config/` subdirectory to bootstrap the Guacamole database and deploys 3
containers to provide the Guacamole gateway.

Steps:

1. Create an Elastic IP to use with the VPC you create in step 2.
2. Create a VPC with 1 public subnet and 1 private subnet using the VPC wizard and use your EIP for the gateway.
3. Review and update the `guacamole-variables.sh` script to use the correct credentials, VPC, subnet, etc.
4. Run the `guacamole-host-setup.sh` script from inside its containing folder as the docker-machine scp command uses a
relative path.


### REQUIRED manual steps

After executing the script, you MUST do the following steps manually:


#### 1. Assign the elastic IP associated with lab.rx-m.net

The reserved IP and DNS need to be assigned to the EC2 instance you just spun up with Docker Machine.

- In the AWS Management Console, select EC2
- Click on "Instances" in the left-side navigation
  - Select the "guacamole-host" from the table and copy its Instance ID
- Click on "Elastic IPs" in the left-side navigation
  - Select the EIP named "lab-rx-m-net-do-not-delete"
  - Open the "Actions" menu and select "Associate address"
  - On the Associate address page, select:
    - Resource type: Instance
    - Instance: (paste the Instance ID here)
    - Private IP: open the drop-down menu and select the one private IP associated with your Instance

The act of doing this will break Docker Machine, but you can recover by using the command:

`docker-machine regenerate-certs guacamole-host`

This will fix the connection between the local client and the remote machine.

Go to Route53


#### 2. Update the VPC security groups


#### Add HTTP rule to the public subnet security group

(If the "docker-machine" security group pre-exists, a rule for HTTP may also already be added to the group)

- In the AWS Management Console, select EC2
- Click on "Security Groups" in the left-side navigation
  - Select the "docker-machine" security group from the list
- In the bottom pane, select the "Inbound" tab
  - Click on "Edit"
- In the "Edit inbound rules" pop up, click "Add Rule"
  - In the "Type" column, for your new rule, open the drop-down menu and select "HTTP"
  - In the "Source" column, open the drop-down menu and select "Anywhere"
  - Click "Save"


#### Add accept rule to private subnet from public subnet

- In the AWS Management Console, select EC2
- Click on "Security Groups" in the left-side navigation
  - Select the private subnet's security group from the list
- In the bottom pane, select the "Inbound" tab
  - Click on "Edit"
- In the "Edit inbound rules" pop up, click "Add Rule"
  - In the "Type" column, for your new rule, open the drop-down menu and select "All traffic"
  - In the "Source" column, open the drop-down menu and select "Custom"
  - In the text box, enter the ID of the "docker-machine" public subnet
  - Click "Save"


#### 3. Change user passwords

Log into Guacamole at http://lab.rx-m.net/guacamole/. The admin credentials are `guacadmin/ubuntu` and should also be
changed after first login!

Navigate to the "guacadmin" menu in the top right corner and select "Settings".

On the Settings page, select "Users" from the tabs along the top left. There will be 25 users named studentXX.

Click on "student01".
- Under Edit User, update the password
- Scroll to the bottom of the page and click "Save"

Repeat the above steps for the number of lab users. Unused Users _do not_ need to be deleted and can safely be ignored.


#### 4. Connect lab VMs to Guacamole

To connect student VMs to Guacamole, first spin up your VMs in the EC2 console and make note of their DNS names (for
example: ec2-54-153-7-218.us-west-1.compute.amazonaws.com).

Navigate to the "guacadmin" menu in the top right corner and select "Settings".

On the Settings page, select "Connections" from the tabs along the top left. There will be 25 connections.

Click on "student01-lab".
- Under the "Parameters" category, find the "Network" section.
- Find the "Hostname" text box and update the value to one of the new DNS entries.
- Scroll to the bottom of the page and click "Save"

Repeat the above steps for the number of lab VMs you are using. Unused Users and Connections _do not_ need to be deleted
and can safely be ignored.

The MySQL container uses a Docker volume so that its data is saved on the host filesystem beyond container restarts (but
not if the host dies or is deleted).


(Probably will switch to Ansible in the future just to accomplish all of this stuff at once and leverage better features.)


### Teardown

Teardown is accomplished with the `guac-teardown.sh` script. It only tears down the guacamole host, not the student VMs,
delete your student VMs via the AWS Management Console.
