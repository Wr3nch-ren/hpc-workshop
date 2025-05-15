## SLURM

### 1. ติดตั้ง Dependencies

> VM ในการอบรมได้ทำการติดตั้ง Dependencies และดาวน์โหลด slurm ไว้เรียบร้อยแล้ว

```bash
sudo apt install libmariadb-dev libhwloc-dev liblz4-dev pkg-config libglib2.0-dev libreadline-dev libfreeipmi-dev liblua5.1-0-dev libpam0g-dev libdbus-1-dev libpmix-dev openmpi-bin openmpi-common libopenmpi3 libopenmpi-dev -y
```

### 2. ดาวน์โหลด SLURM

```bash
sudo wget https://download.schedmd.com/slurm/slurm-24.11.5.tar.bz2
```

## สำหรับ SlurmDBD

### 1. ติดตั้ง Dependencies

```bash
sudo apt install mariadb-server mariadb-client -y
```

### 2. ติดตั้ง SlurmDBD

```bash

```
