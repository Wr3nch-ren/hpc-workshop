## FreeIPA

FreeIPA คือ Identity Management (IdM) ที่ให้บริการการจัดการผู้ใช้และกลุ่มในระบบ Linux โดยมีฟีเจอร์ที่สำคัญเช่น

- Single Sign-On (SSO)
- Kerberos Authentication
- LDAP Directory Service
- Certificate Management
- DNS Management
- Host-Based Access Control (HBAC)
- Policy Management
- Audit and Logging
- Web-Based Management Interface (UI)
- Privilege Access Management (PAM)

โดยเราจะใช้ FreeIPA ในรูปแบบของ Containerized Application โดยใช้ Docker Compose ในการจัดการ Container ต่างๆ

## การติดตั้ง FreeIPA

### 1. ติดตั้ง Docker และ Docker Compose

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```

เพิ่มผู้ใช้ปัจจุบันเข้าไปในกลุ่ม docker เพื่อให้สามารถรันคำสั่ง docker ได้โดยไม่ต้องใช้ sudo

```bash
sudo usermod -aG docker $USER
su - ${USER}
```

ตรวจสอบการติดตั้ง Docker

```bash
docker -v
docker compose version
```

เสร็จสิ้นการติดตั้ง Docker และ Docker Compose

### 2. Clone Repository

```bash
git clone https://github.com/HPC-Thailand/hpc-workshop.git
cd hpc-workshop/FreeIPA
```

### 3. สร้างไฟล์ .env

```bash
cp .env.template .env
```

### 4. แก้ไขไฟล์ .env

```bash
# แก้ไขค่าในไฟล์ .env ตามต้องการ
# ตัวอย่าง
# FreeIPA server hostname (must match FQDN and resolve correctly)
IPA_SERVER_HOSTNAME=ipa.hpc.local

# FreeIPA domain name (DNS)
IPA_DOMAIN=hpc.local

# FreeIPA Kerberos realm (usually uppercase)
IPA_REALM=HPC.LOCAL

# Initial admin user password (set securely in your real .env)
IPA_ADMIN_PASSWORD=changeme

# Directory manager password (set securely in your real .env)
IPA_PASSWORD=changeme

# Optional: enable verbose debug logs (true/false)
DEBUG_TRACE=true
```

### 5. รัน FreeIPA

```bash
docker compose up -d
```

ตรวจสอบสถานะของ Container

```bash
docker compose ps
docker logs -f freeipa-server
```

### 6. ตั้งค่า Firewall

หากคุณใช้ Firewall บนเซิร์ฟเวอร์ FreeIPA คุณต้องเปิดพอร์ตที่จำเป็นสำหรับ FreeIPA

```bash
sudo firewall-cmd --permanent --add-service={ldap,ldaps,kerberos,dns,http,https}
sudo firewall-cmd --reload
```

### 7. เข้าสู่ FreeIPA Web UI

เปิดเว็บเบราว์เซอร์และไปที่ URL ต่อไปนี้

```bash
http://<IPA_SERVER_HOSTNAME>/ipa/ui/
```

หรือ

```bash
http://<IPA_SERVER_IP>/ipa/ui/
```

เข้าสู่ระบบด้วยชื่อผู้ใช้และรหัสผ่านที่กำหนดในไฟล์ .env
