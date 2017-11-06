#!/bin/bash

curl -L https://github.com/apprenda/kismatic/releases/download/v1.6.0/kismatic-v1.6.0-linux-amd64.tar.gz | tar -zx
useradd -d /home/kismaticuser -m kismaticuser
echo "kismaticuser:kismaticpass" | chpasswd
echo "kismaticuser ALL = (root) NOPASSWD:ALL" | tee /etc/sudoers.d/kismaticuser
chmod 0440 /etc/sudoers.d/kismaticuser
ssh-keygen -t rsa -b 4096 -f kismaticuser.key -P ""
mkdir /home/kismaticuser/.ssh
cat kismaticuser.key.pub >> /home/kismaticuser/.ssh/authorized_keys
./kismatic install apply --skip-preflight
kubectl patch service heapster -p '{"spec":{"type":"NodePort"}}' -n kube-system
kubectl patch service heapster --type=json -p '[{"op":"replace", "path": "/spec/ports/0/nodePort", "value": 31382}]' -n kube-system
