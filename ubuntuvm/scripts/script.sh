#!/bin/bash

echo ">>> SET UP THE DOCKER REPOSITORY"

sudo apt-get update
sudo apt-get -y install ca-certificates curl gnupg wget apt-transport-https software-properties-common


sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null



echo ">>> INSTALL DOCKER ENGINE"

sudo apt-get update -y
sudo apt-get -y remove docker docker-engine docker.io containerd runc
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin



echo ">>> FINISH DOCKER SETUP"

sudo systemctl enable docker.service
sudo systemctl enable containerd.service

sudo docker version



echo ">>> INSTALLING MINIKUBE"

sudo curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/



echo ">>> STARTING A KUBERNETES CLUSTER WITH MINIKUBE"

sudo usermod -aG docker vagrant && newgrp docker
su - vagrant -c "/usr/local/bin/minikube start"



echo ">>> INSTALLING THE KUBERNETES CLIENT (KUBECTL)"

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
&& chmod +x kubectl && sudo mv kubectl /usr/local/bin/



echo ">>> CHECKING TO SEE THE CLUSTER IS UP AND KUBECTL CAN TALK TO IT"

su - vagrant -c "/usr/local/bin/kubectl cluster-info"


echo ">>> PREPARE ENVIRONMENT"

echo "alias docker=\"sudo /usr/bin/docker\"" >> /home/vagrant/.bash_profile
echo "alias k=kubectl" >> /home/vagrant/.bash_profile
echo "source <(kubectl completion bash)" >> /home/vagrant/.bash_profile
echo "source <(kubectl completion bash | sed s/kubectl/k/g)" >> /home/vagrant/.bash_profile




