### SeaweedFS

## 🧾 Setup Guide: SeaweedFS on 3-node Cluster (VMs or Raspberry Pi 4)

### 🖥️ Prerequisites

- 3 nodes with SSD mounted as `/data`
- OS: Ubuntu 22.04 or Raspberry Pi OS 64-bit
- Install Go or download prebuilt binaries from GitHub (chrislusf/seaweedfs)

### 🧱 Topology

- 1 Master
- 3 Volume servers
- 1 optional Filer (for POSIX)

### 📦 Download SeaweedFS

```bash
wget https://github.com/seaweedfs/seaweedfs/releases/download/3.62/seaweedfs-linux-arm64.tar.gz
# or amd64 version
```

Extract and place binaries in `/usr/local/bin`

### 🚀 Start SeaweedFS Services

On Master node:

```bash
weed master -mdir=/data -port=9333 &
```

On each Volume node:

```bash
weed volume -dir=/data -max=5 -mserver="node1:9333" -port=8080 &
```

Optional Filer for POSIX:

```bash
weed filer -master="node1:9333" -port=8888 &
```

### 🔗 Mount via FUSE (POSIX)

Install FUSE client:

```bash
sudo apt install fuse -y
```

Run mount:

```bash
weed mount -dir=/mnt/seaweedfs -filer=localhost:8888 &
```

### 🌐 Use as S3 API

Run S3 gateway:

```bash
weed s3 -filer=localhost:8888 -port=8333 &
```

Access via:

```
http://localhost:8333
```

---
