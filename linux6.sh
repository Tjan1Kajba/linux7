#!/bin/bash

folders='Desktop Documents Downloads Pictures Videos'
for folder in $folders
do
    mkdir $folder
    echo "Ustvarjena mapa $folder"
done


for i in {1..5}
do
    mkdir "folder$i"
    echo "Ustvarjena mapa folder$i"
done


wget -q -O uporabniki.txt "https://raw.githubusercontent.com/Tjan1Kajba/linux7/main/uporabniki.txt"
input=uporabniki.txt
while IFS= read -r username
do
        
    if grep $username /etc/passwd > /dev/null 
    then
        echo "Uporabnik $username že obstaja"
    else    
        useradd -G sudo -m $username
        echo "Ustvarjen uporabnik: $username"
    fi
done < "$input"


if apt-get update
then
    apt-get upgrade -y
fi

sudo apt-get install ufw
sudo apt-get install git
sudo apt-get install nginx -y
sudo apt-get install net-tools


if apt-get install -y ca-certificates curl gnupg lsb-release
then
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
echo "Konec :)"
