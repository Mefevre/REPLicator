echo -e "Installation des dépandances :"
echo -e "       - figlet"
sudo apt install  figlet
echo -e "       - lolcat"
sudo apt install  lolcat
echo -e "       - python3"
sudo apt install  python3
echo -e "       - curl"
sudo apt install curl

echo -e "       - clone du dépot"
cd /etc
sudo git clone https://github.com/Mefevre/REPLicator.git
sudo ln -s /etc/REPLicator/REPLicator.sh /usr/bin/REPLicator
sudo chmod 770 /usr/bin/REPLicator 

echo -e "Installation complette !"