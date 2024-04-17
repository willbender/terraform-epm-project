# Needed tasks for the project.

1. [ ] Create AWS account.
2. [ ] Create user "will" for the final task.
3. [ ] Create credentials for will user.
4. [ ] Create S3 Bucket for tf state lock.
5. [ ] Make first test with terraform and tf state.
6. [ ] Create architecture diagram.
7. [ ] Create vpc and subnets via terraform.
8. [ ] Create bastion host via terraform (Install Ansible on it).
9. [ ] Create MySQL via terraform.
10. [ ] Investigate if possible to make frontend via S3 Bucket.
11. [ ] If previous task is possible then create frontend with bucket, if not create frontend with EC2 instance and Ansible.
12. [ ] Create Backend with terraform.
13. [ ] Configure Backend with ansible via bastion host.
14. [ ] Configure load balancer via terraform.
15. [ ] Configure workspaces for terraform
    1.  [ ] qa
    2.  [ ] prod
16. [ ] Investigate how to monitor the created resources in AWS without a 3 party license.


# Additional topics.

- Backend can be created with scaling group, can it be done inside the free tier.
- NAT GATEWAY cannot be used, use an AMI that allows the private subnets instances to reach the internet.
- Pipeline can be created using GitHub actions so, a branch for each workspace/environment exists (qa, prod) and whenever a push is done to the branch, the terraform pipeline runs and recreate the infrastructure.
- See how to configure terraform, so at the end of some infrastructure creation Ansible task /script to call ansible can be called.