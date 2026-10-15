#!/usr/bin/env bash
# Baseline for every lab VM.
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

cat > /etc/hosts.lab <<'EOF'
192.168.56.10 web
192.168.56.20 db
EOF
grep -q "192.168.56.20 db" /etc/hosts || cat /etc/hosts.lab >> /etc/hosts

apt-get update -qq
apt-get install -y -qq curl net-tools dnsutils lsof htop tree jq ufw >/dev/null

# The lab CLI, available as `lab` inside the VM.
# A wrapper (not a symlink) so it works even when the shared folder from a
# Windows host has no executable bits or has CRLF line endings.
cat > /usr/local/bin/lab <<'EOF'
#!/bin/sh
tmp=$(mktemp)
sed 's/\r$//' /vagrant/lab > "$tmp"
LAB_DIR=/vagrant bash "$tmp" "$@"
rc=$?
rm -f "$tmp"
exit $rc
EOF
chmod 755 /usr/local/bin/lab
echo "Baseline ready on $(hostname)"
