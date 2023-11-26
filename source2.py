import boto3, json, os


    # AWS credentials (ensure they are properly configured)
    #aws_access_key_id = 'YOUR_ACCESS_KEY_ID'
    #aws_secret_access_key = 'YOUR_SECRET_ACCESS_KEY'
region_name = 'us-east-1'

    # EC2 instance configuration
instance_type = 't2.micro'
ami_id = 'ami-053b0d53c279acc90'
security_group_ids = ['sg-095208fa0ef76fb7d']
key_name = 'trufflehog_instance_key'
instance_profile_arn= 'arn:aws:iam::587171375059:instance-profile/final_ec2_profile'

#Iam_Instance_Profile={'Arn': 'arn:aws:iam::587171375059:instance-profile/ec2_intsnace_lambda_ssm'}
def lambda_handler(event, context):
    user_data_script = """#!/bin/bash
# Your UserData script here
sudo apt-get update -y
sudo apt-get install awscli -y
cd /tmp
sudo rm trufflehog_3.57.0_linux_amd64.tar.gz
sudo wget https://github.com/trufflesecurity/trufflehog/releases/download/v3.57.0/trufflehog_3.57.0_linux_amd64.tar.gz
sudo tar -xvf trufflehog_3.57.0_linux_amd64.tar.gz
sudo ./trufflehog github --org=Sage >/tmp/deepali_usser_data3.txt
sudo aws s3 cp deepali_usser_data3.txt s3://trufflehog-git-scan-log/trufflehog-result-folder/
"""

    # Create EC2 client
    ec2 = boto3.client('ec2', region_name=region_name)

    # Launch the instance with UserData
    response = ec2.run_instances(
        ImageId=ami_id,
        InstanceType=instance_type,
        #IamInstanceProfile={'Arn': 'arn:aws:iam::587171375059:instance-profile/ec2_intsnace_lambda_ssm'},
        IamInstanceProfile={'Arn': instance_profile_arn},
        SecurityGroupIds=security_group_ids,
        KeyName=key_name,
        UserData=user_data_script,
        MinCount=1,
        MaxCount=1
    )

    # Extract the instance ID
    instance_id = response['Instances'][0]['InstanceId']
    print(f"Launched EC2 instance with ID: {instance_id}")
