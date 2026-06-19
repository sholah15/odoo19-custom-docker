# odoo19-custom-docker

Custom Docker setup untuk menjalankan **Odoo 19** dengan PostgreSQL menggunakan Docker Compose.

---

## 📋 Prasyarat

Sebelum memulai, pastikan sistem kamu sudah terinstall:

- **OS**: Linux (Ubuntu/Debian direkomendasikan)
- **Docker** >= 24.x
- **Docker Compose** >= 2.x

---

## 🐳 Instalasi Docker

### Ubuntu / Debian

```bash
# 1. Update package index
sudo apt-get update

# 2. Install dependensi
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# 3. Tambahkan GPG key resmi Docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# 4. Tambahkan repository Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 5. Install Docker Engine
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# 6. (Opsional) Jalankan Docker tanpa sudo
sudo usermod -aG docker $USER
newgrp docker
```

### Verifikasi Instalasi Docker

```bash
docker --version
# Output: Docker version 24.x.x, build ...

docker run hello-world
```

---

## 🔧 Instalasi Docker Compose

Docker Compose v2 sudah **tersedia sebagai plugin bawaan** Docker Engine. Namun jika perlu install manual:

### Metode 1: Melalui Plugin Docker (Direkomendasikan)

```bash
# Biasanya sudah terinstall bersama Docker Engine
sudo apt-get install -y docker-compose-plugin

# Verifikasi
docker compose version
# Output: Docker Compose version v2.x.x
```

### Metode 2: Install Binary Standalone (Docker Compose v2)

```bash
# 1. Ambil versi terbaru
COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest \
    | grep '"tag_name"' | cut -d '"' -f4)

# 2. Download binary
sudo curl -SL \
    "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-linux-$(uname -m)" \
    -o /usr/local/bin/docker-compose

# 3. Beri permission eksekusi
sudo chmod +x /usr/local/bin/docker-compose

# 4. Verifikasi
docker-compose --version
# Output: Docker Compose version v2.x.x
```

### Metode 3: Melalui apt (Ubuntu)

```bash
sudo apt-get update
sudo apt-get install -y docker-compose-plugin

# Verifikasi
docker compose version
```

> **Catatan:** Docker Compose v2 menggunakan perintah `docker compose` (tanpa tanda hubung).  
> Docker Compose v1 (deprecated) menggunakan `docker-compose` (dengan tanda hubung).

---

## 🚀 Cara Menjalankan

### 1. Clone Repository

```bash
git clone https://github.com/sholah15/odoo19-custom-docker.git
cd odoo19-custom-docker
```

### 2. Konfigurasi Environment

Salin file environment template (jika tersedia) dan sesuaikan:

```bash
cp .env.example .env
# Edit sesuai kebutuhan
nano .env
```

### 3. Jalankan dengan Docker Compose

```bash
# Jalankan semua service (Odoo + PostgreSQL)
docker compose up -d

# Lihat log
docker compose logs -f

# Cek status container
docker compose ps
```

### 4. Akses Odoo

Buka browser dan akses:

```
http://localhost:8069
```

---

## 🛑 Menghentikan Service

```bash
# Hentikan tanpa menghapus data
docker compose stop

# Hentikan dan hapus container (data tetap aman di volume)
docker compose down

# Hentikan dan hapus semua termasuk volume (⚠️ data hilang!)
docker compose down -v
```

---

## 🔄 Update & Rebuild

```bash
# Pull image terbaru
docker compose pull

# Rebuild dan restart
docker compose up -d --build
```

---

## 📁 Struktur Direktori

```
odoo19-custom-docker/
├── docker-compose.yml      # Konfigurasi Docker Compose
├── .env                    # Variabel environment (buat dari .env.example)
├── addons/                 # Custom addons Odoo
├── config/
│   └── odoo.conf           # Konfigurasi Odoo
└── README.md
```

---

## 🐛 Troubleshooting

### Permission denied saat menjalankan Docker

```bash
sudo usermod -aG docker $USER
newgrp docker
```

### Port 8069 sudah digunakan

Edit `docker-compose.yml` dan ganti port mapping:

```yaml
ports:
  - "8070:8069"  # Ganti 8070 dengan port yang tersedia
```

### Container gagal start

```bash
# Cek log detail
docker compose logs odoo
docker compose logs db
```