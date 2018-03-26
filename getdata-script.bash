#! /bin/bash

sudo apt-get install python
sudo pip install azure
sudo apt-get update 
sudo apt-get install -y libssl-dev libffi-dev python-dev build-essential 
sudo apt-get install -y nodejs-legacy 
sudo apt-get install -y npm
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
sudo apt-get install apt-transport-https
sudo apt-get update 
echo "===========================================Installing Azure CLI 2.0==========================================="
sudo apt-get install azure-cli
sudo apt-get update

wget https://raw.githubusercontent.com/M-priyanka/azuure-nested-temp/master/getdata.py >> getdata.py

count=1001
while [ $count -le 1003 ]
do
   jsonfile=`python getdata.py $count`
   echo $jsonfile >> inputparam-$count.json
   count=`expr $count + 1`
done


