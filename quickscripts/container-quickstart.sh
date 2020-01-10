yum install git -y
yum install -y yum-utils   device-mapper-persistent-data   lvm2
yum-config-manager     --add-repo     https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io -y
systemctl start docker
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-1.5.2.rpm  && sudo rpm -ivh minikube-1.5.2.rpm
minikube start --vm-driver=none --kubernetes-version=1.16.2
minikube config set vm-driver none
yum install vim -y

rm minikube-1.5.2.rpm
sudo yum install -y gcc socat  dep
cat <<EOF >> /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
#yum install kubectl
yum install -y kubectl

cat <<EOF >> vim /etc/rc.d/rc.local

#!/bin/bash
exec 2> /var/log/rc.local.log  # send stderr from rc.local to a log file
exec 1>&2                      # send stdout to the same log file
set -x                         # tell sh to display commands before execution

logger rclocal: Installing Salt Minion

hosting_url="https://gitlab.hosting.neoforge.org/cloud-public/scripts/raw/master/bootstraps/helpers/salt-bootstrap.sh"
hosting_minion_version="https://gitlab.hosting.neoforge.org/cloud-public/scripts/raw/master/bootstraps/helpers/salt_minion_version"
cloud_url="https://gitlab.i.cloud1983.us/cloud-public/scripts/raw/master/bootstraps/helpers/salt-bootstrap.sh"
cloud_minion_version="https://gitlab.i.cloud1983.us/cloud-public/scripts/raw/master/bootstraps/helpers/salt_minion_version"
minionid="$(curl -s http://169.254.169.254/latest/meta-data/instance-id/)"

if [[ $minionid =~ ^i-[0-9a-f]+ ]]; then

        # get info for evo/cloud
        if curl -Isf --max-time 5 "$cloud_url" -o /dev/null; then
                curl "$cloud_url" -o "bootstrap-salt.sh"
                version=`curl "$cloud_minion_version"`
        # get info for hosting
        else
                curl "$hosting_url" -o "bootstrap-salt.sh"
                version=`curl "$hosting_minion_version"`
        fi

        # version found, install specific version
        if [ ! -z "$version" ]; then
                bash bootstrap-salt.sh -D -i $minionid -j '{"log_level": "info"}' git $version
                return=$?
                if [ $return -ne 0 ]; then
                        logger bootstrap: Failed to install version $version, attempting to install latest
                        bash bootstrap-salt.sh -D -i $minionid -j '{"log_level": "info"}'
                fi
        # no version found, install latest
        else
                logger bootstrap: No version found, attempting to install latest
                bash bootstrap-salt.sh -D -i $minionid -j '{"log_level": "info"}'
        fi

else
        logger bootstrap: Failed to find a valid Minion ID, did not install salt
        exit 1
fi

sudo /usr/bin/minikube start --vm-driver=none --kubernetes-version=1.16.2

EOF

