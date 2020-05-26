# Provisioning and Configuration AWS resource with Terraform and Ansible

## Install Terraform
https://learn.hashicorp.com/terraform/getting-started/install.html

``` shell script
wget https://releases.hashicorp.com/terraform/0.12.25/terraform_0.12.25_darwin_amd64.zip -P /tmp
unzip /tmp/terraform_0.12.25_darwin_amd64.zip
mv /tmp/terraform /usr/local/bin/terraform
```

## Install Ansible
https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#from-pip

## Step by Step Guide

#### Creating AWS CLI Profile

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

#### AWS Provider config - `main.tf`
contains aws provider config and providers version controlling.

#### Identity and Access Management - `iam.tf`
Identity and Access Management for S3 and EC2 bucket.

### How to use Makefile

### Introduce Workspaces

### Best Practices
