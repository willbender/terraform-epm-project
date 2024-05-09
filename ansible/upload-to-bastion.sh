#!/bin/bash
scp -r -i "/tmp/william.pem" ansible ec2-user@54.196.0.175:/home/ec2-user/ansible
scp -i "/tmp/william.pem" /tmp/william.pem ec2-user@54.167.97.203:/home/ec2-user/ansible