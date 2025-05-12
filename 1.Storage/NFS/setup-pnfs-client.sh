#!/bin/bash
set -e

# Replace with the IP address of your pNFS server
PNFS_SERVER_IP="192.168.x.x"

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
