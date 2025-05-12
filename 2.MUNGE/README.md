### การติดตั้งและใช้งาน MUNGE

MUNGE (MUNGE Uid 'N' Gid Emporium) เป็นระบบที่ใช้ในการจัดการ UID/GID ของผู้ใช้ในระบบคลัสเตอร์ โดยเฉพาะในระบบที่มีการใช้งาน HPC (High Performance Computing) เพื่อให้สามารถเข้าถึงทรัพยากรต่างๆ ระหว่าง Nodes ได้อย่างปลอดภัยและมีประสิทธิภาพ โดยในส่วนของการประมวลผล UID/GID จะถูกใช้ในการตรวจสอบสิทธิ์การเข้าถึงทรัพยากรต่างๆ ในระบบคลัสเตอร์ เช่น การเข้าถึงไฟล์ การใช้งาน CPU และ Memory เป็นต้น MUNGE จะช่วยให้การจัดการ UID/GID เป็นไปอย่างมีระเบียบและปลอดภัย โดยเฉพาะในระบบที่มีผู้ใช้หลายคนและมีการใช้งานทรัพยากรต่างๆ ร่วมกัน และทำงานร่วมกับระบบอื่นๆ เช่น SLURM, OpenMPI, และ PBS/Torque

---

## การติดตั้ง MUNGE จะมีขั้นตอนดังนี้

### สร้าง Global User และ Group

สำหรับ munge

```bash
export MUNGEUSER=9901
sudo groupadd -g $MUNGEUSER munge
sudo useradd -m -c "MUNGE" -d /var/lib/munge -u $MUNGEUSER -g munge -s /sbin/nologin munge --system munge --no-create-home

```

สำหรับ slurm

```bash
export SLURMUSER=9902
sudo groupadd -g $SLURMUSER slurm
sudo useradd -m -c "SLURM" -d /var/lib/slurm -u $SLURMUSER -g slurm -s /sbin/nologin slurm --system slurm --no-create-home
```

ติดตั้ง MUNGE ทุกๆ Node ใน Cluster

### 1. ติดตั้ง Dependencies

```bash

sudo apt update
sudo apt install build-essential libssl-dev ntp libibverbs-dev libnuma-dev bzip2 zlib1g-dev
```

### 2. ดาวน์โหลด MUNGE

```bash
wget https://github.com/dun/munge/releases/download/munge-0.5.16/munge-0.5.16.tar.xz
```

### 3. แตกไฟล์

```bash
tar -xvf munge-0.5.16.tar.xz
cd munge-0.5.16
```

### 4. configure, make, install

```bash
./configure \
     --prefix=/usr \
     --sysconfdir=/etc \
     --localstatedir=/var \
     --runstatedir=/run
make
make check
sudo make install
```
