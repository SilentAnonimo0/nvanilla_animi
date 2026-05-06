#!/bin/bash
# Move to the venv and home
source /opt/venv/bin/activate
cd /home/container

# Output GPU status for your logs
nvidia-smi

echo "Starting Animi Backend..."

# Using 'exec' is what makes the Stop button work!
exec python3 server.py
