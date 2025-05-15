## BeeGFS

https://doc.beegfs.io/latest/quick_start_guide/quick_start_guide.html

## 🧾 Setup Guide: BeeGFS on 3-node Cluster (VMs or Raspberry Pi 4)

### 🖥️ Prerequisites

- 1 management node, 2 client/server nodes
- Each with SSD mounted as `/mnt/beegfs`
- OS: Ubuntu 22.04 or Raspberry Pi OS 64-bit

### 📦 Install BeeGFS

Import the key and repo:

```bash
wget https://www.beegfs.io/release/beegfs_8.0/gpg/GPG-KEY-beegfs -O /etc/apt/trusted.gpg.d/beegfs.asc
wget https://www.beegfs.io/release/beegfs_8.0/dists/beegfs-jammy.list \
-O /etc/apt/sources.list.d/beegfs.list
sudo apt install apt-transport-https
sudo apt update
```

Install components:

```bash
# On all nodes
sudo apt install beegfs-mgmtd beegfs-meta beegfs-storage beegfs-client beegfs-tools beegfs-utils -y

# If use RDMA
sudo apt install libbeegfs-ib -y

```

### 🧠 Configure BeeGFS

Edit `/etc/beegfs/beegfs-mgmtd.conf` on mgmtd node:

```bash
storeMgmtdDirectory = /mnt/beegfs/mgmtd
```

Edit `/etc/beegfs/beegfs-meta.conf` and `/etc/beegfs/beegfs-storage.conf` on compute nodes:

```bash
storeMetaDirectory = /mnt/beegfs/meta
storeStorageDirectory = /mnt/beegfs/storage
```

Edit `/etc/beegfs/beegfs-client.conf` on all client nodes:

```bash
sysMgmtdHost = node1
```

### 🚀 Start Services

On mgmtd node:

```bash
sudo systemctl start beegfs-mgmtd
```

On other nodes:

```bash
sudo systemctl start beegfs-meta
sudo systemctl start beegfs-storage
sudo systemctl start beegfs-helperd
sudo systemctl start beegfs-client
```

Enable all at boot:

```bash
sudo systemctl enable beegfs-*
```

### 🔗 Mount BeeGFS

On clients:

```bash
sudo mkdir /mnt/beegfs
sudo mount -t beegfs none /mnt/beegfs
```

---
