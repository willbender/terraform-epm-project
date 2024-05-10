#!/bin/bash
#This script creates the infrastructure via tofu/terraform.
#When the infra is ready, saves the output important information.
#Upload the configuration files to the created bastion host.
#Execute the configuration from the bastion host.
#Open the browser pointing to frontend to check the result.
echo "Starting terraform module with key $1"
#Execute tofu init 
echo "tf init - **********************************"
tofu init
#Execute tofu plan and save the results in a file
echo "tf plan - **********************************"
tofu plan -out=plan-file
#Execute tofu apply with the previously saved file from the plan
echo "tf apply - **********************************"
tofu apply "plan-file"
#Save variables from the result of the apply to use them later
echo "tf output - **********************************"
BASTION_IP="$(tofu output -raw bastion_ip)"
BACKEND_DNS="$(tofu output -raw backend_dns)"
FRONTEND_IP="$(tofu output -raw frontend_ip)"
#As the elb dns is not always the same. the file shall be updated with the newly generated dns to save the environment variable needed
echo "Update elb dns - **********************************"
sed -i 's/BACKEND_URL=.*.:3000/BACKEND_URL='"${BACKEND_DNS}"':3000/g' ansible/front_end.yml
#Upload configuration files to bastion host
echo "upload config files - **********************************"
scp -r -i "$1" -o StrictHostKeyChecking=no ansible ec2-user@"${BASTION_IP}":/home/ec2-user/ansible
#Upload key to be able to connect to the instances
echo "upload key - **********************************"
scp -i "$1" -o StrictHostKeyChecking=no $1 ec2-user@"${BASTION_IP}":/home/ec2-user/ansible
#Execute configuration script on bastion host, to configure database, frontend and backend
echo "Configuring servers via bastion-host - **********************************"
ssh -i "$1" -o StrictHostKeyChecking=no -t  ec2-user@"${BASTION_IP}" 'cd /home/ec2-user/ansible && sh configure-servers.sh'
#Open the browser local with the frontend ip to check if everything was ok
echo "opening browser - **********************************"
sensible-browser http://"${FRONTEND_IP}":3030