#!/bin/bash
set -e

# # Replace with the IP address of your pNFS server
# PNFS_SERVER_IP="10.100.x.xxx"

if [ -z "$PNFS_SERVER_IP" ]; then
  echo "PNFS_SERVER_IP is not set or is empty"
  exit 1
else
  echo "PNFS_SERVER_IP is set to: $PNFS_SERVER_IP"
fi

echo "📦 Installing NFS client tools..."
sudo apt update
sudo apt install -y nfs-common

echo "📁 Creating mount point..."
sudo mkdir -p /mnt/pnfs

echo "🔗 Mounting pNFS from server..."
sudo mount -t nfs4 -o vers=4.2 ${PNFS_SERVER_IP}:/ /mnt/pnfs

echo "📝 Configuring /etc/fstab..."
echo "${PNFS_SERVER_IP}:/ /mnt/pnfs nfs4 vers=4.2,_netdev,defaults 0 0" | sudo tee -a /etc/fstab

echo "✅ NFS pNFS client setup complete!"
