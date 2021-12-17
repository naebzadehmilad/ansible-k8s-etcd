sudo ETCDCTL_API=3 etcdctl endpoint status --write-out=table --endpoints=https://10.240.0.10:2379 --cacert=/etc/etcd/ca.pem --cert=/etc/etcd/kubernetes.pem --key=/etc/etcd/kubernetes-key.pem
