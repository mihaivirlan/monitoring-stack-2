---
author: Viorel Anghel @esolutions.ro
title: Vagrant full monitoring stack
date: Oct 24, 2019
---

# Vagrant full stack
- This will produce a setup with many VirtualBox VMs running on your workstation.  
- It was created for experimenting with Grafana but it can be used in other purposes too.
 
---
# Requirements
- VirtualBox and Vagrant installed
- at least 20 GB RAM workstation (with only 16 I would recommend to leave out either cassandra or kafka VMs)

---
# The monitoring stack
- I have used https://github.com/stefanprodan/dockprom
- Adapted it to our needs (rancher 1.6, /persistence)
- this will setup Prometheus and Grafana

---
# Step by step usage:

1. run ```./run-this.sh```. this takes about 20 minutes on my laptop
2. manual steps - access in browser http://rancher:8080 and:
    - http://rancher:8080/ -> admin -> settings -> Host Registration URL -> http://192.168.134.10:8080 -> Save!
    - http://rancher:8080/ -> Infrastructure -> Hosts: to add hosts in rancher (via ssh root@docker1/2)
    - http://rancher:8080/ -> Stacks -> User -> Add stack: to create the monitoring-stack and monitoring-client stacks using dockprom/docker-compose*
3. access grafana at http://docker1:3000 (admin:admin)

Enjoy the graphs!

# To stop it all
You may need those vagrant commands (all to be ran in this directory):
- ```vagrant status```
- ```vagrant halt``` will stop all VMs 
- ```vagrant up``` will bring stopped VMs up
- ```vagrant destroy --parallel``` will destroy all VMs AND snapshots (```./run-this.sh``` again to recreate the setup)

To return to unconfigured VMs - snapshots created after vagrant step:
```bash
for h in rancher docker{1,2} cassandra{1,2,3} kafka{1,2,3} gluster{1,2,3} ; do vagrant snapshot restore $h ${h}-t0 ; done
```

# Important URLs in this setup
- http://rancher:8080
- http://docker1:3000 # Grafana (admin:admin)
- http://docker1:9090 # Prometheus (admin:admin)
- http://docker1:9091 # Pushgateway (admin:admin)
- http://docker1:9093 # Alertmanager (admin:admin)

Raw data on nodes:
- http://docker1:8080/ # cadvisor
- http://docker1:9100/metrics # nodeexporter
- http://cassandra1:9404/ # jmx exporter data
- http://kafka1:9404/ # jmx exporter data

# Host ssh keys
If you kill and restart the system, you will have problems with cached ssh keys. To solve this, check the config snippets from the ```ssh_config``` file and add to you ```~/.ssh/config``` file.
 
# Customizations
Read in this order:
- etc_hosts # this is the list of VMs which will be created
- Vagrantfile # this is how the VMs are created
- bootstrap.sh # ran from Vagrantfile on each VM for minimal VM setup
- ansible/* # this is how the VMs are configured
- dockprom/docker-compose*yml # those are the stack definitions
- dockprom/prometheus/*.yml # config files which will be on /persistence/monitoring-stack/prometheus etc
- dockprom/grafana/dashboards/*.yml # grafana dashboards
- run-this.sh # a simple shell script which wraps some convenience tasks plus vagrant and ansible run.
- to edit the prometheus config file after install, do ssh as root on docker1 and see 
/persistence/monitoring-stack/prometheus directory (you will need to upgrade/restart the container in rancher webinterface)



