#!/bin/bash
set -e

echo "📦 Installing NFS server tools..."
sudo apt update
sudo apt install -y nfs-kernel-server

echo "📁 Creating export directory..."
sudo mkdir -p /data/pnfs
sudo chown nobody:nogroup /data/pnfs
sudo chmod 777 /data/pnfs

echo "🔧 Configuring /etc/exports..."
echo "/data/pnfs *(rw,fsid=0,no_subtree_check,insecure,sync,no_root_squash)" | sudo tee /etc/exports

echo "🚀 Enabling and starting NFS server..."
sudo systemctl enable --now nfs-server

echo "📡 Exporting the directory..."
sudo exportfs -rav

echo "✅ NFS pNFS master setup complete!"
