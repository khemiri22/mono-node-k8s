#!/bin/sh
# setup-ssh.sh - SSH key generation with required SSH_USER and HOST_IP
# Usage: ./setup-ssh.sh -U <SSH_USER> -H <HOST_IP>

# Enable strict error handling
# set -euo pipefail

# === Variables ===
KEY_TYPE="ed25519"
KEY_COMMENT="mail@ansible.com"
KEY_DIR="$HOME/.ssh"
KEY_NAME="id_${KEY_TYPE}_$(date +%s)"   # change this if you want a custom filename
KEY_PATH="$KEY_DIR/$KEY_NAME"
HOST="mono"

usage() {
  echo "Usage: $0 -U SSH_USER -H HOST_IP"
  echo "Options:"
  echo "  -U SSH_USER       User for SSH connection (required)"
  echo "  -H HOST_IP        Target host IP (required)"
  echo "  -h                Show this help message"
  exit 1
}

# === Parse command line options ===
while getopts "U:H:h" opt; do
  case $opt in
    U) SSH_USER="$OPTARG" ;;
    H) HOST_IP="$OPTARG" ;;
    h) usage ;;
    *) usage ;;
  esac
done

# Check required options
if [ -z "$SSH_USER" ] || [ -z "$HOST_IP" ]; then
  echo "[!] Error: -U SSH_USER and -H HOST_IP are required."
  usage
fi

# === Create .ssh directory if missing ===
mkdir -p "$KEY_DIR"
chmod 700 "$KEY_DIR"

# === Generate SSH key if it doesn't exist ===
if [ ! -f "$KEY_PATH" ]; then
  echo "[*] Generating SSH key..."
  ssh-keygen -q -t "$KEY_TYPE" -C "$KEY_COMMENT" -f "$KEY_PATH" -N ""
  echo "[+] Key generated: $KEY_PATH"
else
  echo "[*] SSH key already exists: $KEY_PATH"
fi

# === Show public key ===
echo "[*] Public key: $(cat "${KEY_PATH}.pub")"

# === Create ssh config file if missing ===
touch "$KEY_DIR/config"
chmod 600 "$KEY_DIR/config"

cat >> "$KEY_DIR/config" <<EOF
# ========================
# $HOST host entries
# ========================

Host $HOST
  HostName $HOST_IP
  User $SSH_USER
  Port 22
  IdentityFile $KEY_PATH
  AddKeysToAgent yes
  ForwardX11 no
  ForwardAgent no
  ServerAliveInterval 60
EOF