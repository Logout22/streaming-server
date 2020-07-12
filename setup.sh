#!/bin/sh -eux
apt update
apt dist-upgrade -y
apt install -y nginx libnginx-mod-rtmp
echo "
rtmp {
        server {
                listen 1935;
                chunk_size 4096;

                application live {
                        live on;
                        record off;
                }
        }
}" >> /etc/nginx/nginx.conf
systemctl restart nginx
iptables -A INPUT -m state --state NEW -p tcp --dport 1935 -j ACCEPT
netfilter-persistent save
