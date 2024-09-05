from flask import Flask, jsonify  # Import Flask framework and jsonify for converting data to JSON response
from kubernetes import client, config  # Import Kubernetes client and config for API interactions

# Initialize the Flask application
app = Flask(__name__)

# Define the root route that displays a welcome message
@app.route('/')
def welcome():
    return "Welcome to the Flask Application!"

# Define a route to list all pods in the 'kube-system' namespace
@app.route("/pods")
def list_pods():
    # Load the Kubernetes configuration, using the default config file usually located at ~/.kube/config
    config.load_kube_config()
    
    # Create an instance of the CoreV1Api to interact with the Kubernetes API
    v1 = client.CoreV1Api()
    
    # List all pods within the 'kube-system' namespace
    pods = v1.list_namespaced_pod(namespace='kube-system')
    
    # Create a list of dictionaries containing pod names and their namespaces
    pod_list = [{"name": pod.metadata.name, "namespace": pod.metadata.namespace} for pod in pods.items]
    
    # Return the list of pods as a JSON response
    return jsonify(pod_list)

# Run the Flask application on host 0.0.0.0 and port 5000
if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)


