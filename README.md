# Kubernetes Basics
> Getting up and running and learning Kubernetes from an end user perspective

<img src="images/Kubernetes-training-in-Hyderabad.jpeg" width="600" height="300" align="center" />

## Purpose
Kubernetes does not have a low learning curve. Kubernetes is a platform for building platform, but its far from the endgame. This repository aims to help teach the basics so that you can get up and running in about two and a half weeks.

### The definition of done is as follows:
- [ ] Chapter 1 - The basics of Linux
- [ ] Chapter 2 - The basics of Git
- [ ] Chapter 3 - The basics of Docker
- [ ] Chapter 4 - The basics of Kubernetes
- [ ] Chapter 5 - The basics of Helm
- [ ] Chapter 6 - The basics of Rancher
- [ ] Chapter 7 - A deeper dive into Kubernetes 
- [ ] Chapter 8 - Down the Rabbit hole of Kubernetes
- [ ] Chapter 9 - Deeper and Deeper w/ service meshs, containerizing the virtual machine, + serverless
- [ ] Chapter 10 - Putting it all together and Understanding where we are going

### QuickStart
If for some reason you need a new minikube you can simply run the following script as root
```
yum install git -y
yum install -y yum-utils   device-mapper-persistent-data   lvm2
yum-config-manager     --add-repo     https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io
yum install docker-ce docker-ce-cli containerd.io -y
systemctl start docker
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-1.4.0.rpm  && sudo rpm -ivh minikube- 1.4.0.rpm
minikube start --vm-driver=none
minikube config set vm-driver none
yum install vim -y
rm minikube-1.4.0.rpm
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl
sudo cp -R /root/.kube ~/ && sudo cp -R /root/.minikube ~/
sudo chown -R $USER .kube .minikube /root/.minikube /root
```
