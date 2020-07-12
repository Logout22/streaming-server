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
