## Flask Application with AWS Resources
#### Overview
This repository contains a Flask application and a Python script to create EC2 instances using AWS Boto3.

#### Prerequisites
* Python 3.9 or higher
* AWS CLI (for managing AWS resources)
* Boto3 (for creating AWS resources programmatically)
#### Running the Flask App Locally
Install Dependencies: Make sure you have all the required dependencies. You can install them using requirements.txt:
```
pip install -r requirements.txt
```
##### Run Flask Application:

```
python app/app.py
```
The Flask application will be accessible at http://127.0.0.1:5000.

##### AWS Resources
This repository contains a Python script for creating EC2 instances.

###### Creating EC2 Instances with Boto3
To create EC2 instances with a Python script, follow these steps:

###### Install Boto3:

```
pip install boto3
```
###### Run the EC2 Creation Script: Update the ami_id, subnet_id values, access_key, secret_key and region_name in create_ec2.py and run the script:

```
python scripts/create_ec2.py
```
