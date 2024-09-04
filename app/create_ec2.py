import boto3

# Function to create an EC2 instance with a specific AMI instance type, and subnet
def create_ec2_instance(ami_id, instance_type, subnet_id):
    ec2 = boto3.resource('ec2')
    instance = ec2.create_instances(
        ImageId=ami_id,
        InstanceType=instance_type,
        SubnetId=subnet_id,
        MinCount=1,
        MaxCount=1
    )
    print(f"Created EC2 instance with ID: {instance[0].id}")

if __name__ == "__main__":
    # AMI ID for the instance to be launched
    ami_id = "ami-02c21308fed24a8ab"
    # Instance type to be launched
    instance_type = "t3.micro"
    # Subnet ID where the instance will be placed
    subnet_id = "subnet-0a40e7beb104e25cb"
    # Call the function to create the EC2 instance with the specified parameters
    create_ec2_instance(ami_id, instance_type, subnet_id)
