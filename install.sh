path="$(dirname $(readlink -f $0))"

echo -e "Installation des dépandances :"
echo -e "       - figlet"
sudo apt install  figlet
echo -e "       - lolcat"
sudo apt install  lolcat
echo -e "       - python3"
sudo apt install  python3
echo -e "       - curl"
sudo apt install curl

echo -e "       - REPLicator"
sudo mv $path /etc/
sudo ln -s /etc/REPLicator/REPLicator.sh /usr/bin/REPLicator

echo -e "Installation complette !"