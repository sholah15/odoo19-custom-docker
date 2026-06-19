# odoo19-custom-docker

Custom Docker setup untuk menjalankan **Odoo 19** dengan PostgreSQL menggunakan Docker Compose.

## Prasyarat

- Docker >= 24.x
- Docker Compose >= 2.x

## Cara Menjalankan

```bash
# Clone repo
git clone https://github.com/sholah15/odoo19-custom-docker.git
cd odoo19-custom-docker

# Salin dan sesuaikan env
cp .env.example .env

# Jalankan
docker compose up -d
```

Akses Odoo di: `http://localhost:8069`

## Perintah Umum

```bash
docker compose logs -f       # Lihat log
docker compose ps            # Cek status
docker compose stop          # Hentikan service
docker compose down          # Hentikan & hapus container
docker compose down -v       # ⚠️ Hapus semua termasuk data
docker compose up -d --build # Rebuild & restart
```

## Struktur Direktori

```
odoo19-custom-docker/
├── docker-compose.yml
├── .env
├── addons/
├── config/
│   └── odoo.conf
└── README.md
```