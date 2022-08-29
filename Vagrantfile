# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.


  config.vm.define "auth-users" do |web|
    web.vm.box = "ubuntu/focal64"
    web.vm.hostname = 'auth-users-apis'
    web.vm.synced_folder "/Users/diego.puentes/Documents/IT_Excercises", "/vagrant_data"
#    web.vm.box_url = "ubuntu/focal64"

    web.vm.network :private_network, ip: "192.168.56.10"

    web.vm.provision "shell", path: "/Users/diego.puentes/Documents/IT_Excercises/scripts/install-go.sh"
    web.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--name", "auth-users-apis"]
    end
  end

  config.vm.define "redisdb" do |db|
    db.vm.box = "ubuntu/focal64"
    db.vm.hostname = 'dbredis'
    db.vm.synced_folder "/Users/diego.puentes/Documents/IT_Excercises", "/vagrant_data"
#    db.vm.box_url = "ubuntu/focal64"

    db.vm.network :private_network, ip: "192.168.56.11"

    db.vm.provision "shell", path: "/Users/diego.puentes/Documents/IT_Excercises/scripts/redis-install.sh"
    db.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--name", "dbredis"]
    end
  end

  config.vm.define "logmessage-todos" do |web|
    web.vm.box = "ubuntu/focal64"
    web.vm.hostname = 'logmessage-todos-apis'
    web.vm.synced_folder "/Users/diego.puentes/Documents/IT_Excercises", "/vagrant_data"
#    web.vm.box_url = "ubuntu/focal64"

    web.vm.network :private_network, ip: "192.168.56.12"

    web.vm.provision "shell", path: "/Users/diego.puentes/Documents/IT_Excercises/scripts/logmessage-todos.sh"
    web.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--name", "logmessage-todos"]
    end
  end


  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  #config.vm.box = "ubuntu/focal64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
