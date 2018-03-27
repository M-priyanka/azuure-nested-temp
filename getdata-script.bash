#! /bin/bash
sudo apt install -y python-pip
sudo pip install azure
sudo apt-get install jq -y
sudo apt-get update

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
sleep 10
sudo cd /
sudo cd /tmp
sudo mkdir iot-demo-labs
cd /tmp/iot-demo-labs
sudo wget https://raw.githubusercontent.com/sysgain/IOTLabs/EMSDemoLabs-Dev/scripts/getdata.py?token=AT7l1cLRwtCUocH6DqiZ85WpEW6Moa8Qks5awnQmwA%3D%3D >>/tmp/iot-demo-labs
mv getdata.py?token=AT7l1cLRwtCUocH6DqiZ85WpEW6Moa8Qks5awnQmwA%3D%3D getdata.py
sudo wget https://raw.githubusercontent.com/M-priyanka/azuure-nested-temp/master/input.bash
#sudo wget https://raw.githubusercontent.com/sysgain/IOTLabs/EMSDemoLabs-Dev/scripts/input.bash?token=AT7l1WsxVGJeVh_TaAeG58aOqXnHFXpiks5awnRZwA%3D%3D >>/tmp/iot-demo-labs
#mv input.bash?token=AT7l1WsxVGJeVh_TaAeG58aOqXnHFXpiks5awnRZwA%3D%3D input.bash
sudo sh input.bash >>/tmp/iot-demo-labs
sleep 20

sudo wget https://raw.githubusercontent.com/sysgain/IOTLabs/EMSDemoLabs-Dev/main-template.json?token=AYpAeEC1KIuZTsq1i9oBD0CbekQioIIdks5awmk_wA%3D%3D
sudo mv main-template.json?token=AYpAeEC1KIuZTsq1i9oBD0CbekQioIIdks5awmk_wA%3D%3D  main-template.json

 inputfile=`ls -t inputparam-* | head -1`


 url=`jq .INPUTURL.value $inputfile`
 urltemp="${url%\"}"
 urltemp="${urltemp#\"}"
sudo wget $urltemp



username=`jq .username.value $inputfile`
 usernametemp="${username%\"}"
 usernametemp="${usernametemp#\"}"

 password=`jq .password.value $inputfile`
 passwordtemp="${password%\"}"
 passwordtemp="${passwordtemp#\"}"

tenant=`jq .tenant.value $inputfile`
tenanttemp="${tenant%\"}"
tenanttemp="${tenanttemp#\"}"

az login --service-principal -u $usernametemp -p $passwordtemp --tenant $tenanttemp

#rgno="${inputfile:11:4}"
#echo $rgno
rgno=$1

inputparam=`ls -t INPUTPARAM-* | head -1`

mv $inputparam inputparameter.json

#az group create --name emsdemolabs-$rgno --location "WEST US"

az group deployment create --template-file './main-template.json' --parameters '@./inputparameter.json' -g $rgno -n deploy
