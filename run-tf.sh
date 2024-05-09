#!/bin/bash
echo "tf plan"
tofu plan -out=plan-file
echo "tf apply"
tofu apply "plan-file"
echo "tf output"
BASTION_IP="$(tofu output -raw bastion_ip)"
echo "upload ansible files"
scp -r -i "/tmp/william.pem" -o StrictHostKeyChecking=no ansible ec2-user@"${BASTION_IP}":/home/ec2-user/ansible
echo "upload key"
scp -i "/tmp/william.pem" -o StrictHostKeyChecking=no /tmp/william.pem ec2-user@"${BASTION_IP}":/home/ec2-user/ansible