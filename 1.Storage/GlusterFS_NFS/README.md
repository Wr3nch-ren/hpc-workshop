## GlusterFS with NFSv4.2 (pNFS) Setup Guide

## 🧾 Setup Guide: GlusterFS on 3-node Cluster (VMs or Raspberry Pi 4)

### 🖥️ Prerequisites

- 3 nodes with hostname: `node1`, `node2`, `node3`
- Each with a secondary SSD mounted at `/mnt/brick`
- OS: Ubuntu 22.04 or Raspberry Pi OS 64-bit

### 📦 Install GlusterFS

```bash
sudo apt update
sudo apt install glusterfs-server -y
```

### 🔗 Peer Probe

On `node1`:

```bash
sudo gluster peer probe node2
sudo gluster peer probe node3
```

Check peer status:

```bash
sudo gluster peer status
```

### 📁 Create Brick Directory

```bash
sudo mkdir -p /mnt/brick/vol1
sudo chown -R gluster:gluster /mnt/brick
```

Repeat on all 3 nodes.

### 🧱 Create Gluster Volume

On `node1`:

```bash
sudo gluster volume create vol1 replica 3 \
  node1:/mnt/brick/vol1 \
  node2:/mnt/brick/vol1 \
  node3:/mnt/brick/vol1

sudo gluster volume start vol1
```

### 🔗 Mount with NFSv4.2 (pNFS)

Install NFS client:

```bash
sudo apt install nfs-common -y
```

Mount (on clients or compute nodes):

```bash
sudo mount -t nfs4 -o nfsvers=4.2 node1:/vol1 /mnt/gluster
```

---
