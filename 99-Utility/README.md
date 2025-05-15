# Utility scripts for various tasks

### Install Docker

```bash
curl -fsSL https://get.docker.com -o get-docker.sh \
sudo sh get-docker.sh

sudo usermod -aG docker ${USER}
su - ${USER}

Try CMD!
# docker -v
# docker compose version
```

### Install pip3 / venv

```bash
sudo apt install python3-pip python3-venv
```
