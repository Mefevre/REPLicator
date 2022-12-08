path="$(dirname $(readlink -f $0))"

echo -e "Installation des dépandances :"
echo -e "       - figlet"
sudo apt install  figlet -y > /dev/null
echo -e "       - lolcat"
sudo apt install  lolcat -y > /dev/null
echo -e "       - python3"
sudo apt install  python3 -y > /dev/null
echo -e "       - curl"
sudo apt install curl -y > /dev/null

echo -e "       - REPLicator"
sudo mv $path /etc/
sudo ln -s /etc/REPLicator/REPLicator.sh /usr/bin/REPLicator

echo -e "Installation complette !"