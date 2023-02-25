ansible -m shell k8s -a 'echo nameserver 185.51.200.1 > /etc/resolv.conf ; apt upgrade -y kubeadm=1.23.16-00 kubectl=1.23.16-00 kubelet=1.23.16-00' -i inventory.yml
apt-mark hold kubelet kubeadm kubectl
