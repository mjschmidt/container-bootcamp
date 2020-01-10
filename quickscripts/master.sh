localdir=$(pwd)
echo $localdir
cp ./container-quickstart.sh $HOME/
cp ./non-root-setup.sh $HOME
cd $HOME
sudo ./container-quickstart.sh
./non-root-setup.sh
rm $HOME/container-quickstart.sh
rm $HOME/non-root-setup.sh
cd $localdir
