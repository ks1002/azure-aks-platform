from flask import Flask, jsonify
import os
import socket

app = Flask(__name__)

SECRET_PATH = "/mnt/secrets-store/test-secret"


@app.get("/")
def home():
    return jsonify({
        "application": "aksplatform-backend",
        "message": "Backend is running",
        "environment": os.getenv("APP_ENV", "dev")
    })


@app.get("/health")
def health():
    return jsonify({
        "status": "healthy"
    }), 200


@app.get("/api/status")
def status():
    return jsonify({
        "status": "running",
        "hostname": socket.gethostname(),
        "environment": os.getenv("APP_ENV", "dev")
    })


@app.get("/api/secret-status")
def secret_status():
    return jsonify({
        "secretMounted": os.path.exists(SECRET_PATH)
    })


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
