#!/bin/bash

echo "Installing Docker"
sudo apt update && sudo apt -y upgrade
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt -y update
sudo apt install -y docker-ce=18.06.1~ce~3-0~ubuntu
sudo usermod -aG docker ${USER}

echo "Installing and Setting Up Kubernetes" 
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get -y  update
sudo apt-get install -y kubelet kubeadm kubectl
sudo docker info | grep -i cgroup
sudo cat /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
sudo sed -i "s/cgroup-driver=systemd/cgroup-driver=cgroupfs/g" /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
sudo systemctl daemon-reload
sudo systemctl restart kubelet
sudo swapoff -a
sudo kubeadm init --pod-network-cidr=192.169.0.0/16 --apiserver-advertise-address=192.169.34.10
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sudo kubectl taint nodes --all node-role.kubernetes.io/master-
sudo kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml
sudo kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml
sudo kubectl apply -f /home/vagrant/src/yml/kubernetes-dashboard.yml
sudo kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard

echo "Insytalling and Configuring Mysql" 
sudo apt-get install -y mysql-server
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo service mysql restart
sudo mysql -u root -e "grant all on *.* to 'test'@'%' identified by 'test123'"
sudo mysql -u root -e "create database springbootdb"

echo "Building Docker Image for Application"
cd /home/vagrant/src/relevancelab/
sudo docker build -t appimg:v1 .
sudo docker pull hshar/mysql:5.5
sudo kubectl run javatestapp --image=appimg:v1 --port=8081
sudo kubectl run mysqldb --image=hshar/mysql:5.5 --port=3306
sudo kubectl expose deployment javatestapp --type=NodePort
sudo kubectl expose deployment mysqldb


