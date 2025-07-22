#!/bin/bash

set -e


VERSION=1.28.15-1.1
K8S_VERSION="v${VERSION%-*}"
echo $K8S_VERSION
function init() {
  sudo apt-get update
  sudo apt-get install -y apt-transport-https ca-certificates curl gpg

  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key \
    | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg

  echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" \
    | sudo tee /etc/apt/sources.list.d/kubernetes.list

  sudo apt-get update

  kubeadm upgrade plan || true

  sudo apt-mark unhold kubeadm
  sudo apt-get install -y kubeadm=$VERSION
  sudo apt-mark hold kubeadm
}

function pull_images() {
  kubeadm config images list --kubernetes-version $K8S_VERSION
  echo " kubeadm config images pull --kubernetes-version  $K8S_VERSION"
  kubeadm config images pull --kubernetes-version $K8S_VERSION

  images=($(kubeadm config images list --kubernetes-version $K8S_VERSION))

  for img in "${images[@]}"; do
    echo "pulling $img"
    nerdctl -n k8s.io pull "$img"
  done
}
#init
pull_images
