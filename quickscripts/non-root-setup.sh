#install go
curl -O https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz
tar -xvf go1.13.4.linux-amd64.tar.gz
sudo chown -R root:root ./go
sudo mv go /usr/local
mkdir -p ~/go/src/hello && cd ~/go/src/
export PATH=$PATH:/usr/local/go/bin
echo export PATH=$PATH:/usr/local/go/bin >> ~/.bashrc
cd ~/go/src/
curl -o helm-v3.0.0.tar.gz -L https://github.com/helm/helm/archive/v3.0.0.tar.gz
tar -zvxf helm-v3.0.0.tar.gz
rm -f helm-v3.0.0.tar.gz
cd helm-3.0.0
make
sudo mv bin/helm /usr/bin/
helm version
#move minikube executables
cd ~/
sudo cp -R /root/.kube ~/ && sudo cp -R /root/.minikube ~/
sudo chown -R $USER .kube .minikube /root/.minikube /root

