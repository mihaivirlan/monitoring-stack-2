
=begin
You may comment whole sections in Vagrant file
with this =begin =end trick 
as you see here
=end

Vagrant.configure(2) do |config|
  
# rancher
  config.vm.define "rancher" do |node|
    node.vm.hostname = "rancher"
    node.vm.box = "ubuntu/bionic64"
    node.vm.synced_folder ".", "/vagrant", disabled: false
    node.vm.network "private_network", ip: "192.168.9.10"
    node.vm.provision "shell", path: "./bootstrap.sh"
    node.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048", "--cpus", "2"]
    end
  end

# docker1,2
  (1..2).each do |i|
    config.vm.define "docker#{i}" do |node|
      node.vm.hostname = "docker#{i}"
      node.vm.box = "ubuntu/bionic64"
      node.vm.synced_folder ".", "/vagrant", disabled: false
      node.vm.network "private_network", ip: "192.168.9.1#{i}"
      node.vm.provision "shell", path: "./bootstrap.sh"
      node.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "1024", "--cpus", "2"]
      end
    end
  end

# gluster1,2,3
  (1..3).each do |i|
    config.vm.define "gluster#{i}" do |node|
      node.vm.hostname = "gluster#{i}"
      node.vm.box = "ubuntu/bionic64"
      node.vm.synced_folder ".", "/vagrant", disabled: false
      node.vm.network "private_network", ip: "192.168.9.4#{i}"
      node.vm.provision "shell", path: "./bootstrap.sh"
      node.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "2"]
      end
    end
  end

# cassandra1,2,3
  (1..3).each do |i|
    config.vm.define "cassandra#{i}" do |node|
      node.vm.hostname = "cassandra#{i}"
      node.vm.box = "ubuntu/bionic64"
      node.vm.synced_folder ".", "/vagrant", disabled: false
      node.vm.network "private_network", ip: "192.168.9.2#{i}"
      node.vm.provision "shell", path: "./bootstrap.sh"
      node.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "2048", "--cpus", "2"]
      end
    end
  end

# kafka1,2,3
  (1..3).each do |i| 
    config.vm.define "kafka#{i}" do |node|
      node.vm.hostname = "kafka#{i}"
      node.vm.box = "ubuntu/bionic64"
      node.vm.synced_folder ".", "/vagrant", disabled: false
      node.vm.network "private_network", ip: "192.168.9.3#{i}"
      node.vm.provision "shell", path: "./bootstrap.sh"
      node.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "1024", "--cpus", "2"]
      end 
    end 
  end 

# vagrant end config
end
