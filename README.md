![stability-wip](https://img.shields.io/badge/stability-work_in_progress-lightgrey.svg)
![last-commit](https://img.shields.io/github/last-commit/imilad/aws-terraform-ansible)


# Provisioning and Configuration AWS resource with Terraform and Ansible

## AWS Architecture Diagram
Lucidchart [Diagram](https://app.lucidchart.com/documents/view/f438462e-3310-45fe-8d7b-a7490f82b6ff/0_0)

## Install Terraform
https://learn.hashicorp.com/terraform/getting-started/install.html

``` shell script
wget https://releases.hashicorp.com/terraform/0.12.25/terraform_0.12.25_darwin_amd64.zip -P /tmp
unzip /tmp/terraform_0.12.25_darwin_amd64.zip
mv /tmp/terraform /usr/local/bin/terraform
```

## Install Ansible
https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#from-pip

### Creating AWS CLI Profile

`aws configure --profile dev`

>```
>AWS Access Key ID [None]: XXXX
>AWS Secret Access Key [None]: XXXX
>Default region name [None]: us-east-1
>Default output format [None]: yml
>```
>~/.aws/config
>
>```
>[profile dev]
>region = us-east-1
>output = yaml
>```
>~/.aws/credentials
>```[dev]
>aws_access_key_id=
>aws_secret_access_key=
>```

### How to use Makefile
**Note** 

* Makefile is using plan file for applying new infrastructure so always run `make plan ENV=<YOUR-ENV>` at first and then `make apply`. (this is a best practice for terraform to always run at first `terraform plan` and then `apply`.)

* run `make help` for get available commands

### Create terraform workspaces (envs)
`terraform workspace new dev`

`terraform workspace new prod`

Create  ssh key
---------------
```
$ ssh-keygen
```
