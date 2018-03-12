# By Luis Nesi - luis.nesi@ibm.com
# Requires vagrant plugin install vagrant-triggers

# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-7"
  config.vm.network "private_network", ip: "192.168.100.100"
  
  config.vm.provider "virtualbox" do |v|
	  v.memory = 2048
	  v.cpus = 2
  end
  
  # Uncomment lines 21 and 22 after provision
  config.vm.synced_folder "./magento", "/data/magento",
  	    rsync__exclude: [".git/",".settings/","public/var/", "public/pub/"] , owner: "vagrant", group:"apache"
  
  config.vm.host_name = "teststore.magento.local"
  config.vm.provision "shell", path: "provision/provision.sh"

end
