# Use the official Python 3.9 slim image as the base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /

# Copy the requirements.txt file into the container
COPY requirements.txt requirements.txt

# Install the Python dependencies listed in requirements.txt
RUN pip install -r requirements.txt

# Copy the entire contents of the current directory into the container
COPY . .

# Expose port 5000 to allow traffic to reach the Flask application
EXPOSE 5000

# Define the command to run the Flask application when the container starts
CMD ["python", "app/app.py"]

