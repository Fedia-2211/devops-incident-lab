#!/usr/bin/env bash
# Healthy database server: MariaDB listening on the private network.
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

apt-get install -y -qq mariadb-server >/dev/null

sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
systemctl restart mariadb
systemctl enable mariadb >/dev/null

mysql <<'SQL'
CREATE DATABASE IF NOT EXISTS appdb;
CREATE USER IF NOT EXISTS 'app'@'192.168.56.%' IDENTIFIED BY 'apppass';
GRANT ALL PRIVILEGES ON appdb.* TO 'app'@'192.168.56.%';
FLUSH PRIVILEGES;
CREATE TABLE IF NOT EXISTS appdb.orders (id INT PRIMARY KEY AUTO_INCREMENT, item VARCHAR(64));
INSERT INTO appdb.orders (item) SELECT 'welcome-order' WHERE NOT EXISTS (SELECT 1 FROM appdb.orders);
SQL

echo "Database ready: appdb on 192.168.56.20:3306 (user app / apppass)"
