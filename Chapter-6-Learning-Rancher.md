# Learning the Rancher Basics

<img src="images/rancher-logo-horiz-color.png" width="500" height="75" align="center" />

### Get two new VMs
You'll need two to six new VMs for this exercise. If you haven't written basic bash scripts for installing docker on a few nodes, now is a great time to revisit some previous sections!

* Google how to create a private and public RSA key
  * https://www.ssh.com/ssh/putty/windows/puttygen
  * http://lunar.lyris.com/help/lm_help/12.0/Content/generating_public_and_private_keys.html
* Use the script to install docker on every node
* Run single node rancher install on a node
* Use rancher to install a kubernetes cluster 1 master 4 workers

### Rancher Docs
https://rancher.com/docs/rancher/v2.x/en/

### Upgrading Rancher
You may use the following script to upgrade a single node rancher at anytime automatically. This script must be run on the machine that your user origonally setup rancher on.
```
#/bin/bash

# get the current version of rancher running on your host machine
oldContainerVersion=$(docker ps | grep -v CONTAINER | grep rancher/rancher | cut -c -42 | cut -c 37-)
#get the latest stable rancher version from the github releases page
newContainerVersion=$(curl https://github.com/rancher/rancher/releases | grep /rancher/rancher/releases/tag | grep -v Please | sed 's/<a href="\/rancher\/rancher\/releases\/tag\///g' | sed 's/".*//g' | grep -v rc | grep -v alpha | grep -v beta | head -n 1 | sed 's/ //g')
#get the current running rancher container name
containerName=$(docker ps | grep -v CONTAINER | grep rancher/rancher | cut -c 128-)
#get the current running rancher container id
containerID=$(docker ps | grep rancher | cut -c -12)
#set the date for the purposes of this script to be able to appropriately label everything and delete old backups
date=$(date | sed 's/ /-/g' | sed 's/--/-/g' | sed 's/:/-/g' | awk '{print tolower($0)}')

#stop the container
docker stop $containerName

#create a moutable volume for your new container with the data of the stopped container
docker create --volumes-from $containerName --name rancher-data-$date rancher/rancher:$oldContainerVersion

#create a busybox container to retrieve said backup incase something goes wrong during upgrade
docker run --volumes-from rancher-data-$date --name busybox-$date -v $PWD:/backup busybox tar zcvf /backup/rancher-backup-$oldContainerVersion-$date.tar.gz /var/lib/rancher

#run the new rancher container on only port 443 (https) with the old data being mounted in
docker run -d --volumes-from rancher-data-$date --name rancher-$date   --restart=unless-stopped   -p 443:443     rancher/rancher:$newContainerVersion


echo
echo done!
echo these containers could be cleaned up now
docker ps -a --format {{.Names}}  | grep -v $date
docker ps -a --format {{.Names}}  | grep -v $date > tmp-file.txt

#remove all the old contianers so you can save your disk space
docker rm $(cat tmp-file.txt)

#remove all unused images
docker rmi $(docker images -q)

#move the backup to home directory
mv rancher-backup-$oldContainerVersion-$date.tar.gz ~/

#delete all old backup files (comment this out if you want to keep your backups)
rm -f ~/$(ls ~/ | grep 'rancher-backup' | grep -v $date)

#remove all temp files
rm -f *.txt *.tar.gz
```
