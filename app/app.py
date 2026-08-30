from flask import Flask
import socket

app = Flask(__name__)

@app.route("/")
def home():
    hostname = socket.gethostname()
    return f"""
    <html>
      <head><title>DevOps Minor Project</title></head>
      <body style="font-family: Arial; text-align:center; margin-top: 80px;">
        <h1>🚀 Hello from AWS + Docker + Terraform + GitHub Actions!</h1>
        <p>This page is being served from container: <b>{hostname}</b></p>
        <p>If you can see this, the whole pipeline worked end-to-end.</p>
      </body>
    </html>
    """

@app.route("/health")
def health():
    return {"status": "ok"}, 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
