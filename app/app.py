from flask import Flask
from kubernetes import client, config

app = Flask(__name__)

@app.route('/')
def welcome():
    return "Welcome to the Flask Application!"

@app.route("/pods")
def list_pods():
    config.load_kube_config()
    v1 = client.CoreV1Api()
    pods = v1.list_namespaced_pod(namespace='kube-system')
    # return {"pods": [pod.metadata.name for pod in pods.items()]}
    pod_list = [{"name": pod.metadata.name, "namespace": pod.metadata.namespace} for pod in pods.items]
    return jsonify(pod_list)

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)

