# Learning the Docker Basics

<img src="images/1_uitUVFjILAHXSdG6JshpPg.png" width="400" height="100" align="center" />

## CheatSheet

```
#Add your user without needing sudo
sudo usermod -aG docker $USER
```

```
#List all docker images and tags on a machine
docker images --format {{.Repository}} > name_docker_images.tmp && docker images --format {{.Tag}} > name_docker_tags.tmp
sed -i 's/$/:/' name_docker_images.tmp
paste name_docker_images.tmp name_docker_tags.tmp > imagelist.txt
rm name_docker_images.tmp name_docker_tags.tmp
sed -i 's/\t//g' imagelist.txt
cat imagelist.txt

#once you verify delete imagelist file
rm imagelist.txt
```

### Try Docker Online
https://www.katacoda.com/courses/docker

### Do you have a VM?
Make sure you have a VM

### Installing Docker
Use this guide to [install docker on CentOS7](https://docs.docker.com/install/linux/docker-ce/centos/)

### Free Online Start Up Guide
https://docker-curriculum.com/

### Full Docker Docs Guide
https://docs.docker.com/
