#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

install-a() {

cd ~

rm -rf v2ray-linux-64.zip go.sh

wget -nc --no-check-certificate https://raw.githubusercontent.com/2444989513/Backup-v2ray/master/go.sh

wget -nc --no-check-certificate https://raw.githubusercontent.com/2444989513/Backup-v2ray/master/v2ray-kernel-1/v2ray-linux-64.zip

rm -rf /etc/systemd/system/v2ray.service
rm -rf /etc/systemd/system/v2ray@.service

sudo systemctl daemon-reload

bash go.sh --local v2ray-linux-64.zip

rm -rf v2ray-linux-64.zip go.sh

chown -R nobody:nogroup /var/log/v2ray/
chown -R nobody:nobody /var/log/v2ray/

systemctl enable v2ray.service

systemctl restart v2ray.service

/usr/bin/v2ray/v2ray -version

}

install-a

# mv /root/.cache/bazel/_bazel_root/5571c66d5bb940674a99e2337ba11798/execroot/v2ray_core/bazel-out/k8-fastbuild/bin/release /root/test/Backup-v2ray/v2ray-kernel-1
# wget https://install.direct/go.sh
# https://raw.githubusercontent.com/2444989513/Backup-v2ray/master/install.sh

