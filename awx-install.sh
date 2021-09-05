#!/usr/bin/env bash
set -euo pipefail
sudo apt update
sudo apt-get install -y software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu\
 $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
sudo systemctl restart docker
sudo docker version
curl -s https://api.github.com/repos/docker/compose/releases/latest \
  | grep browser_download_url | grep docker-compose-Linux-x86_64 \
  | cut -d '"' -f 4 | wget -qi -
sudo chmod +x docker-compose-Linux-x86_64
sudo mv docker-compose-Linux-x86_64 /usr/local/bin/docker-compose
sudo docker-compose version
sudo apt install -y ansible
ansible --version
sudo apt install -y nodejs npm
sudo npm install npm --global
sudo apt install -y python3-pip git pwgen
sudo pip3 install docker-compose==1.28.5
wget https://github.com/ansible/awx/archive/15.0.0.zip
unzip -o 15.0.0.zip
cd awx-15.0.0/installer/
sudo rm ./inventory
curl -s https://raw.githubusercontent.com/AutomateWithAWX/AWX_Ubuntu_Automated_Install/main/files/inventory -o $PWD/inventory
ansible-playbook -i inventory install.yml
sudo systemctl restart docker
x-www-browser 'http://localhost'
