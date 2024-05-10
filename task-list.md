# Needed tasks for the project.

1. [X] Create AWS account.
2. [X] Create user "will" for the final task.
3. [X] Create credentials for will user.
4. [X] Create S3 Bucket for tf state lock.
5. [X] Create DynamoDB table for LockID.
6. [X] Make first test with terraform and tf state.
7. [X] Create architecture diagram.
8. [X] Create vpc and subnets via terraform.
9. [X] Create MySQL via terraform.
10. [X] Create a NAT instance via terraform.
11. [X] Create bastion host via terraform (Install Ansible on it).
12. [X] Create Frontend with terraform.
13. [X] Create DNS with Route 53.
14. [X] Create Backend & load balancer with terraform.
15. [X] Configure Backend & Frontend with ansible via bastion host.
16. [ ] Configure workspaces for terraform
    1.  [ ] qa
    2.  [ ] prod


# Additional topics.

- Pipeline can be created using GitHub actions so, a branch for each workspace/environment exists (qa, prod) and whenever a push is done to the branch, the terraform pipeline runs and recreate the infrastructure.

# Ultimas tareas

1. Documentar código de terraform, incluido los módulos.
2. Documentar código de ansible.
4. Documentar código bash.