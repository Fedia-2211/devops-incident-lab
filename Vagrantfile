# DevOps Incident Lab - two VMs on a private network
#   web  192.168.56.10  Ubuntu 22.04, Nginx (host port 8080 -> guest 80)
#   db   192.168.56.20  Ubuntu 22.04, MariaDB
# Needs about 2 GB free RAM. First `vagrant up` downloads the box (~600 MB).

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.box_check_update = false

  config.vm.define "db" do |db|
    db.vm.hostname = "db"
    db.vm.network "private_network", ip: "192.168.56.20"
    db.vm.network "forwarded_port", guest: 22, host: 2201, id: "ssh"
    db.vm.provider "virtualbox" do |vb|
      vb.name   = "lab-db"
      vb.memory = 1024
      vb.cpus   = 1
    end
    db.vm.provision "shell", path: "provision/common.sh"
    db.vm.provision "shell", path: "provision/db.sh"
  end

  config.vm.define "web", primary: true do |web|
    web.vm.hostname = "web"
    web.vm.network "private_network", ip: "192.168.56.10"
    web.vm.network "forwarded_port", guest: 22, host: 2202, id: "ssh"
    web.vm.network "forwarded_port", guest: 80, host: 8080
    web.vm.provider "virtualbox" do |vb|
      vb.name   = "lab-web"
      vb.memory = 1024
      vb.cpus   = 1
    end
    web.vm.provision "shell", path: "provision/common.sh"
    web.vm.provision "shell", path: "provision/web.sh"
  end
end
