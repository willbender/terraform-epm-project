#!/bin/bash
#This script is intended to configure ansible on the bastion host, so it can be used to configure the other instances.
#It also installs a mysql so the bastion host can create the database structure and populate it with data
#Install ansible for amazon linux
sudo yum install -y ansible
#Install pip & boto (needed to use dynamic inventories in ansible)
sudo yum install -y python3-pip
sudo pip3 install boto3
#Install mysql to be able to connect and configure the database
sudo dnf update -y
sudo dnf install mariadb105-server -y