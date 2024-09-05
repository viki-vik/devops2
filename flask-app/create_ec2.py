import boto3

# Function to create an EC2 instance with a specific AMI instance type, and subnet
def create_ec2_instance(ami_id, instance_type, subnet_id, access_key, secret_key):
    ec2 = boto3.resource('ec2',
        aws_access_key_id=access_key,
        aws_secret_access_key=secret_key,
        region_name='us-east-1'
    )
    instance = ec2.create_instances(
        ImageId=ami_id,
        InstanceType=instance_type,
        SubnetId=subnet_id,
        MinCount=1,
        MaxCount=1
    )
    print(f"Created EC2 instance with ID: {instance[0].id}")

if __name__ == "__main__":
    # Access key for the AWS account
    access_key = "YOUR ACCESS KEY"
    # Secret key for the AWS account
    secret_key = "YOUR SECRET KEY"
    # AMI ID for the instance to be launched
    ami_id = "ami-02c21308fed24a8ab"
    # Instance type to be launched
    instance_type = "t3.micro"
    # Subnet ID where the instance will be placed
    subnet_id = "subnet-0a40e7beb104e25cb"
    # Call the function to create the EC2 instance with the specified parameters
    create_ec2_instance(ami_id, instance_type, subnet_id, access_key, secret_key)
