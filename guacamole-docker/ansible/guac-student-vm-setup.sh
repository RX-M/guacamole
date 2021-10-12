sudo apt install -y jq

. ./guacamole-variables.sh
touch guac_ec2_dns
ansible-playbook -v ./ansible-guac-vm-setup.yml

echo "Updating guac_db.sql to insert student VM DNS entries..."

cp ../config/guac_db.sql guac_db.sql
sed -i "0,/ec2-3-16-67-239.us-east-2.compute.amazonaws.com/ s//$(sed -n 2p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-3-16-82-153.us-east-2.compute.amazonaws.com/ s//$(sed -n 3p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-3-16-218-246.us-east-2.compute.amazonaws.com/ s//$(sed -n 4p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-3-17-164-89.us-east-2.compute.amazonaws.com/ s//$(sed -n 5p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-13-59-139-4.us-east-2.compute.amazonaws.com/ s//$(sed -n 6p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-18-188-24-175.us-east-2.compute.amazonaws.com/ s//$(sed -n 7p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-18-188-104-183.us-east-2.compute.amazonaws.com/ s//$(sed -n 8p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-18-188-188-159.us-east-2.compute.amazonaws.com/ s//$(sed -n 9p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-18-217-198-77.us-east-2.compute.amazonaws.com/ s//$(sed -n 10p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-3-16-79-116.us-east-2.compute.amazonaws.com/ s//$(sed -n 11p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-18-222-92-106.us-east-2.compute.amazonaws.com/ s//$(sed -n 12p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-18-222-107-54.us-east-2.compute.amazonaws.com/ s//$(sed -n 13p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-18-222-182-166.us-east-2.compute.amazonaws.com/ s//$(sed -n 14p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-18-223-211-74.us-east-2.compute.amazonaws.com/ s//$(sed -n 15p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-18-224-33-14.us-east-2.compute.amazonaws.com/ s//$(sed -n 16p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-52-14-110-72.us-east-2.compute.amazonaws.com/ s//$(sed -n 17p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-52-15-107-39.us-east-2.compute.amazonaws.com/ s//$(sed -n 18p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-52-15-197-81.us-east-2.compute.amazonaws.com/ s//$(sed -n 19p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-18-191-22-216.us-east-2.compute.amazonaws.com/ s//$(sed -n 1p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-18-221-25-20.us-east-2.compute.amazonaws.com/ s//$(sed -n 20p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-18-221-169-9.us-east-2.compute.amazonaws.com/ s//$(sed -n 21p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-18-219-134-159.us-east-2.compute.amazonaws.com/ s//$(sed -n 22p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-13-58-77-212.us-east-2.compute.amazonaws.com/ s//$(sed -n 23p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-13-58-77-212.us-east-2.compute.amazonaws.com/ s//$(sed -n 24p guac_ec2_dns)/" guac_db.sql
sed -i "0,/ec2-13-58-77-212.us-east-2.compute.amazonaws.com/ s//$(sed -n 25p guac_ec2_dns)/" guac_db.sql

echo "guac_db.sql file updated with student VM DNS entries. Please run guac_setup.sh to stand up the Guacamole Server"
