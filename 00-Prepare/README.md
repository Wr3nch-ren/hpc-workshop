## Mini Cluster Preparation

ทางผู้จัดอบรมได้เตรียม Virtual Machine (VM) สำหรับการอบรมไว้แล้ว โดยได้มีการตั้งค่าบางส่วนเพื่อลดขั้นตอนการติดตั้ง และอำนวยความสะดวกให้กับผู้เข้าอบรม

### VM ที่เตรียมไว้แล้ว

โดยผู้เข้าร่วมการอบรมจะได้รับ VM ที่มีการตั้งค่าดังนี้

- Hostname: `vm-00`
- CPU: `4 vCPU`
- RAM: `4 GB`
- Disk: `35 GB`
- OS: `Ubuntu Server 22.04.5 LTS`
- มีการกำหนดค่า IP Address ตามที่ได้จัดสรรไว้ในเอกสารประกอบการอบรม หรือ แจ้งให้ผู้เข้าอบรมทราบในวันอบรม
- มีการติดตั้ง SSH Server และเปิดใช้งานไว้แล้ว

### Step 0 : การเชื่อมต่อ VPN

การอบรมในครั้งนี้จะมีการใช้ Virtual Lab ที่จัดเตรียมไว้ให้ โดยผู้เข้าอบรมจะต้องเชื่อมต่อ VPN เข้ามาในระบบ Virtual Lab ก่อน
จึงจะสามารถ SSH เข้าสู่ VM ที่เตรียมไว้ได้

**หมายเหตุ: การเชื่อมต่อ VPN ผู้เข้าร่วมการอบรมจะได้รับข้อมูลการเชื่อมต่อ VPN จากผู้จัดอบรมในวันอบรม หรือ ก่อนกิจกรรม Workshop จะเริ่มต้น**

### Step 1: การเตรียมความพร้อมของ VM

เนื่องจาก VM ที่เตรียมไว้จะมีการติดตั้ง OS และการกำหนดค่า IP Address แบบ static เอาไว้แล้ว ผู้เข้าอบรมจึงไม่จำเป็นต้องติดตั้ง OS หรือ ติดตั้ง SSH Server Sevice หรือ การกำหนดค่า IP Address แต่จะต้องทำการตั้งค่าเพิ่มเติมบางอย่างเพื่อให้สามารถใช้งานได้ตามที่กำหนดไว้ในเอกสารประกอบการอบรม

เมื่อผู้เข้าอบรมได้เชื่อมต่อ VPN เข้ามาในระบบ Virtual Lab ของทางผู้จัดอบรมแล้ว ให้ทำการ SSH เข้าสู่ VM ที่เตรียมไว้ โดยใช้คำสั่งดังนี้

**โดยใช้ ssh client ที่ติดตั้งไว้ในเครื่องของผู้เข้าอบรม (Termius / MobaXterm / PuTTY หรืออื่นๆ) หรือ ใช้คำสั่งใน terminal ของเครื่องผู้เข้าอบรม**

```bash
ssh hpcth@10.100.x.xxx
```

> หมายเหตุ: .x.xxx คือ การกำหนดค่าหมายเลข IP Address ของ VM ที่แตกต่างกันตามที่ได้รับมอบหมายให้กับผู้เข้าอบรม

> Default username: `hpcth`
> Default password: `HPCth1234`

### Step 2: หลังจาก SSH เข้าสู่ VM

เมื่อผู้เข้าอบรมสามาร SSH เข้าสู่ VM ที่เตรียมไว้ได้เรียบร้อยแล้ว จะพบกับหน้าจอที่แสดงข้อความต้อนรับดังนี้

```bash
vm-00:~$
```

**2.1. เปลี่ยน Hostname ของ VM**
ให้ทำการเปลี่ยน Hostname ของ VM ให้เป็นชื่อที่กำหนดไว้ในเอกสารการอบรม โดยใช้คำสั่งดังนี้

```bash
sudo hostnamectl set-hostname vm-xx
```

> หมายเหตุ: xx คือหมายเลข VM 01-03 ตามแผนภาพ

**2.2 ตั้งค่า timezone**
ให้ทำการตั้งค่า timezone ของ VM ให้เป็น Asia/Bangkok โดยใช้คำสั่งดังนี้

```bash
sudo timedatectl set-timezone Asia/Bangkok
```

**2.3 ตั้งค่า hosts**
ให้ทำการตั้งค่า hosts ของ VM ให้สามารถ resolve hostname ของ VM อื่นๆ ได้ โดยใช้คำสั่งดังนี้

```bash
sudo nano /etc/hosts
```

> หมายเหตุ: ให้เพิ่มบรรทัดด้านล่างนี้ลงไปในไฟล์ hosts

```bash

127.0.0.1 localhost
127.0.1.1 vm-xx

# The following lines are desirable for IPv6 capable hosts
::1 ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
ff02::3 ip6-allhosts

# My HPC Cluster
10.100.x.xxx vm-01
10.100.x.xxx vm-02
10.100.x.xxx vm-03

```

> โดยในบรรทัด vm-xx ให้เปลี่ยน xx เป็นหมายเลข VM และ .x.xxx เป็น IP Address ของ VM ที่ได้รับมอบหมายให้กับผู้เข้าอบรม

> หมายเลข VM และ IP Address ของ VM ที่ได้รับมอบหมายให้กับผู้เข้าอบรม สามารถดูได้จากเอกสารประกอบการอบรม

**2.4 ให้ทำการตั้งค่าเช่นนี้กับ VM อื่นๆ โดยเปลี่ยนหมายเลข VM และ IP Address ให้ตรงกับที่ได้รับมอบหมาย**

**2.A กรณีตั้งค่า static IP Address (Optaional)**
ให้ทำการ comment ทุกบรรทัดในไฟล์ /etc/netplan/50-cloud-init.yaml

```bash
sudo nano /etc/netplan/50-cloud-init.yaml
```

หลังจากนั้นให้ใช้คำสั่งด้านล่างเพื่อปิดการใช้งานการตั้งค่า network ของ cloud-init

```bash
echo "network: {config: disabled}" | sudo tee /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg
```

ทำการสร้างไฟล์ใหม่สำหรับการตั้งค่า static IP Address โดยใช้คำสั่งดังนี้

```bash
sudo nano /etc/netplan/10-static.yaml
```

จากนั้นให้เพิ่มการตั้งค่าดังนี้

```yaml
# Use networkd renderer - configure link-local for Ethernet + static IP
network:
  version: 2
  renderer: networkd

  ethernets:
    ens18:
      dhcp4: no
      addresses: [10.100.2.1/22]
      routes:
        - to: default
          via: 10.100.0.1
      nameservers:
        addresses: [1.1.1.1, 8.8.8.8]
        search: [hpc.in.th]
```

จากนั้นกด `Ctrl + O` เพื่อบันทึกไฟล์ และ `Ctrl + X` เพื่อออกจาก nano editor

หลังจากนั้นให้ใช้คำสั่งด้านล่างเพื่อทำการตั้งค่า network ใหม่

```bash
sudo netplan apply
```

### Step 3: ทดสอบการเชื่อมต่อ

ให้ทำการทดสอบการเชื่อมต่อระหว่าง VM โดยใช้คำสั่ง ping ดังนี้

**ที่ vm-01**

```bash
ping vm-02
ping vm-03
```

**ที่ vm-02**

```bash
ping vm-01
ping vm-03
```

**ที่ vm-03**

```bash
ping vm-01
ping vm-02
```

หากสามารถ ping ได้แสดงว่าการตั้งค่าเสร็จสมบูรณ์

> หากไม่สามารถ ping ได้ให้ตรวจสอบการตั้งค่า IP Address และ Hostname ของ VM ว่าถูกต้องหรือไม่

> หากยังไม่สามารถ ping ได้ให้ติดต่อผู้ดูแลระบบเพื่อขอความช่วยเหลือ

### Step 4: Reboot VM

หลังจากที่ได้ทำการตั้งค่าทุกอย่างเสร็จเรียบร้อยแล้ว ให้ทำการ reboot VM เพื่อให้การตั้งค่าทั้งหมดมีผล

```bash
sudo reboot now
```

### Step 5: ตรวจสอบการตั้งค่า

หลังจากที่ VM รีบูตเสร็จแล้ว ให้ทำการ SSH เข้าสู่ VM อีกครั้ง และตรวจสอบการตั้งค่าดังนี้
**5.1 ตรวจสอบ Hostname**

```bash
hostname
```

**5.2 ตรวจสอบ IP Address**

```bash
ip addr show
```

**5.3 ตรวจสอบการตั้งค่า hosts**

```bash
cat /etc/hosts
```

เมื่อทุกอย่างถูกต้องแล้ว ผู้เข้าอบรมสามารถดำเนินการต่อไปยังขั้นตอนถัดไปได้

### Step 6: ทำการ Clone repository ของการอบรม

ให้ทำการ clone repository ของการอบรมลงใน VM โดยใช้คำสั่งดังนี้

```bash
git clone https://github.com/HPC-Thailand/hpc-workshop.git
```
