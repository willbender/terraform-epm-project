#!/bin/bash
sudo yum install -y ansible
sudo yum install -y python3-pip
sudo pip3 install boto3
sudo dnf update -y
sudo dnf install mariadb105-server -y