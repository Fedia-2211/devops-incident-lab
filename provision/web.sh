#!/usr/bin/env bash
# Healthy web server: Nginx serving a status page, MariaDB client for DB checks.
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

apt-get install -y -qq nginx mariadb-client python3 >/dev/null

cat > /var/www/html/index.html <<'EOF'
<!doctype html>
<html><head><title>Shop status</title></head>
<body><h1>Shop is online</h1><p>Served by web (192.168.56.10)</p></body></html>
EOF
chown -R www-data:www-data /var/www/html
chmod 755 /var/www/html
chmod 644 /var/www/html/index.html

systemctl enable --now nginx >/dev/null
systemctl reload nginx
echo "Web ready: http://localhost:8080 from your laptop"
