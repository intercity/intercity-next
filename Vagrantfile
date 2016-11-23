# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_NAME = ENV["BOX_NAME"] || "bento/ubuntu-16.04"
BOX_MEMORY = ENV["BOX_MEMORY"] || "1024"
DOKKU_DOMAIN = ENV["DOKKU_DOMAIN"] || "dokku.me"
DOKKU_IP = ENV["DOKKU_IP"] || "10.0.0.3"
CLEAN_IP = ENV["DOKKU_IP"] || "10.0.0.2"
FORWARDED_PORT = (ENV["FORWARDED_PORT"] || '8080').to_i
PUBLIC_KEY_PATH = "#{Dir.home}/.ssh/id_rsa.pub"

Vagrant::configure("2") do |config|
  config.ssh.forward_agent = true

  config.vm.box = BOX_NAME

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    # Ubuntu's Raring 64-bit cloud image is set to a 32-bit Ubuntu OS type by
    # default in Virtualbox and thus will not boot. Manually override that.
    vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
    vb.customize ["modifyvm", :id, "--memory", BOX_MEMORY]
  end

  config.vm.define "clean", primary: true do |vm|
    vm.vm.network :forwarded_port, guest: 80, host: FORWARDED_PORT
    vm.vm.hostname = "clean.#{DOKKU_DOMAIN}"
    vm.vm.network :private_network, ip: CLEAN_IP
    vm.vm.provision :shell, inline: "sudo apt-get -yy install vim"
  end

  config.vm.define "dokku", autostart: false do |vm|
    vm.vm.network :forwarded_port, guest: 80, host: FORWARDED_PORT
    vm.vm.network :private_network, ip: DOKKU_IP
    vm.vm.provision :shell, inline: "wget https://raw.githubusercontent.com/progrium/dokku/v0.4.4/bootstrap.sh && sudo DOKKU_TAG=v0.4.4 bash bootstrap.sh"
  end
end
