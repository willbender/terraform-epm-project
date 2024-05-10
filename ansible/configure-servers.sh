#!/bin/bash
#Create structure and data into the database
echo "Configuring database structure - **********************************"
mysql -u  applicationuser -papplicationuser -h moviedb.ctgq2kaq0uwc.us-east-1.rds.amazonaws.com -P 3306 movie_db < movie_db.sql
echo "Configuring database data - **********************************"
mysql -u  applicationuser -papplicationuser -h moviedb.ctgq2kaq0uwc.us-east-1.rds.amazonaws.com -P 3306 movie_db < movie_data.sql
#Configure frontend instances
echo "Configuring frontend servers - **********************************"
ansible-playbook -i aws_ec2.yml front_end.yml
#Configure backend instances
echo "Configuring backend servers - **********************************"
ansible-playbook -i aws_ec2.yml back_end.yml