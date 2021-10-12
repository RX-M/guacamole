# Edit this file to set the environment variables used by the Guacamole host
# The guac-setup.sh script sources this file.

# Docker Machine variables
#
# The AWS Key used by Ansible to stand up the EC2 CI instance.
export AWS_ACCESS_KEY_ID=AKIAWJUO4MRBREJGM5M4

# The AWS secret for the key above
export AWS_SECRET_ACCESS_KEY=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

# AWS AMI; ami-0653e888ec96eab9b is ubuntu 16.04 in ohio
export AWS_AMI=ami-04781752c9b20ea41

# AWS instance type to use for the Guacamole host
# t3.xlarge	is 4 CPU, 16GiB, EBS, $0.1664 per Hour
export AWS_INSTANCE_TYPE="t3a.xlarge"

# The region and AZ to stand the guac instance up in
export AWS_DEFAULT_REGION=us-east-2
export AWS_ZONE=b

# AWS SSH user
export AWS_SSH_USER=ubuntu

# AWS subnet - use the public subnet that was set up as part of the VPC
export AWS_SUBNET_ID=subnet-0e3b3576

# AWS VPC created for the lab
export AWS_VPC_ID=vpc-c1c920a8

# AWS SG for the lab
export AWS_SG_ID=sg-002ca3572d047af84

# Docker Compose variables
#
export MYSQL_ROOT_PASSWORD=T7BvbtG7mNFqs4KY3769
export GUACAMOLE_PASSWORD=ob4bh84XBa

# Echo string for confirmation
#
echo "guacamole variables set"
