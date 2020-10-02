#!/bin/bash
# vang
# Bring up the whole stack

set -e

echo 
echo This will bring up the whole setup
echo


# check if we have VirtualBox and Vagrant installed
if which vagrant >/dev/null 2>&1
then
    :
else
    echo You must install vagrant first.
    exit 1
fi

if which virtualbox >/dev/null 2>&1
then
    :
else
    echo You must install virtualbox first.
    exit 2
fi

# get the ssh public key in this directory
if [ -f ~/.ssh/id_rsa.pub ]
then
    :
else
    echo "You need a ssh public key first (~/.ssh/id_rsa.pub not found)."
    exit 3
fi

[ -f id_rsa.pub ] || cp ~/.ssh/id_rsa.pub .

# setup local /etc/hosts
echo "Setting up the local /etc/hosts"
echo "This may ask for sudo password"
while read l
do
    set -- $l
    [ "x$1" = "x" ] && continue
    [[ $1 == \#* ]] && continue
    
    if fgrep -q "$1" /etc/hosts
    then
      :
    else
      echo $@ | sudo tee -a /etc/hosts >/dev/null
    fi  

done <etc_hosts

# update vagrant boxes (OS images)
vagrant box update

# bring up the VMs # ~ 15 minutes on my laptop
vagrant up 

# save snapshots # ~ 90 seconds on my laptop
for h in rancher docker{1,2} cassandra{1,2,3} kafka{1,2,3} gluster{1,2,3} 
do
   echo $h 
   vagrant snapshot save $h ${h}-t0 
done

# move to ansible provisioning
cd ansible

ansible-playbook gluster-server.yml
ansible-playbook gluster-client.yml

# rancher and docker hosts
ansible-playbook docker.yml
ansible-playbook mysql.yml 
ansible-playbook rancher.yml

# copy dockprom config  files to /persistence/monitoring-stack
ansible-playbook dockprom.yml

# cassandra
ansible-playbook cassandra-install.yml cassandra-config.yml cassandra-rolling-restart.yml

# zookeepr is required by kafka and installed on kafka instances
ansible-playbook zookeeper.yml

# kafka
ansible-playbook kafka-install.yml kafka-config.yml kafka-rolling-restart.yml

# nodeexplorer
ansible-playbook node-exporter.yml

# the end
vagrant status


