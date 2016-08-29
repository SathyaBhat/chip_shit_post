# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"  
  config.vm.network "forwarded_port", guest: 80, host: 8180
  config.vm.synced_folder "..", "/code"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y ruby
    apt-get install -y screen
    apt-get install -y htop
    apt-get install -y git
    apt-get install -y vim
  SHELL
end
