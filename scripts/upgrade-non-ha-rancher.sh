#/bin/bash

oldContainerVersion=$(docker ps | grep -v CONTAINER | grep rancher/rancher | cut -c -42 | cut -c 37-)
#user fill this variable out
newContainerVersion=$(curl https://github.com/rancher/rancher/releases | grep /rancher/rancher/releases/tag | grep -v Please | sed 's/<a href="\/rancher\/rancher\/releases\/tag\///g' | sed 's/".*//g' | grep -v rc | grep -v alpha | grep -v beta | head -n 1 | sed 's/ //g')
containerName=$(docker ps | grep -v CONTAINER | grep rancher/rancher | cut -c 128-)
containerID=$(docker ps | grep rancher | cut -c -12)
date=$(date | sed 's/ /-/g' | sed 's/--/-/g' | sed 's/:/-/g' | awk '{print tolower($0)}')

docker stop $containerName
docker create --volumes-from $containerName --name rancher-data-$date rancher/rancher:$oldContainerVersion
docker run --volumes-from rancher-data-$date --name busybox-$date -v $PWD:/backup busybox tar zcvf /backup/rancher-backup-$oldContainerVersion-$date.tar.gz /var/lib/rancher
docker run -d --volumes-from rancher-data-$date --name rancher-$date   --restart=unless-stopped   -p 443:443     rancher/rancher:$newContainerVersion
echo
echo done!
echo these containers could be cleaned up now
docker ps -a --format {{.Names}}  | grep -v $date
docker ps -a --format {{.Names}}  | grep -v $date > tmp-file.txt

docker rm $(cat tmp-file.txt)
mv rancher-backup-$oldContainerVersion-$date.tar.gz ~/
rm -f ~/$(ls ~/ | grep 'rancher-backup' | grep -v $date)
rm -f *.txt *.tar.gz

