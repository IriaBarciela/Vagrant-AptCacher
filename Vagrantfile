# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"
  config.vm.provider "virtualbox" do |vb|
	vb.memory="1024"
	vb.cpus= 1
	vb.linked_clone = true
	vb.customize ["modifyvm", :id, "--groups", "/E-Apt-Cacher"]
  end

  config.vm.box_check_update = false
  # R-INT
  config.vm.define "ROUTER" do |router|	
  	router.vm.box = "debian/bookworm64"
	router.vm.hostname = "R-INT"
	
	router.vm.network "public_network", bridge: "enp3s0", auto_config: false 
	router.vm.network "private_network", ip: "172.16.1.1", netmask: "255.255.255.0", virtualbox__intnet: "E-ATP-CACHER-LAN"
	
	router.vm.provider "virtualbox" do |vb|
		vb.name="Router"
		vb.memory = "756"
	end
	
	router.vm.provision "shell", name: "configura la interfaz puente", path: "scripts/router/configura-bridge.sh", run: "always"
	router.vm.provision "shell", name: "cambia la puerta de enlace", path: "scripts/router/cambia-default-route.sh", run: "always"
	router.vm.provision "shell", name: "convierte la máquina en un router", inline: "sysctl -w net.ipv4.ip_forward=1", run: "always"
	
	
	#### NFTABLES
	router.vm.provision "shell", name: "copia y carga las regras nftables", inline: "cp /vagrant/scripts/router/nftables.conf /etc && nft -f /etc/nftables.conf", run: "always"
	
  end
  
  # APT-C
  config.vm.define "APT-CACHER" do |apt|	
  	apt.vm.box = "debian/bookworm64"
	apt.vm.hostname = "APT-C"
	
	apt.vm.network "private_network", ip: "172.16.1.2", netmask: "255.255.255.0", virtualbox__intnet: "E-ATP-CACHER-LAN"
	apt.vm.network "public_network", bridge: "enp3s0", ip: "192.168.1.46"

	apt.vm.provider "virtualbox" do |vb|
		vb.name="Apt-Cacher"
		vb.memory = "756"
	end
	
	apt.vm.provision "shell", name: "cambia la puerta de enlace", path: "scripts/apt-cacher/cambia-default-route-LAN.sh", run: "always"
	apt.vm.provision "instala-apache",type: "shell", path: "scripts/apt-cacher/install_apache.sh", run: "once"
	apt.vm.provision "instala-apt-cacher-ng",type: "shell", path: "scripts/apt-cacher/install-apt-cacher-ng.sh", run: "once"
	apt.vm.provision "configura-apt-cacher-ng",type: "shell", path: "scripts/apt-cacher/configura-apt-cacher-ng.sh", run: "always"
	apt.vm.provision "crontab",type: "shell", path: "scripts/apt-cacher/crontab-apt-cacher.sh", run: "always"
	
  end
  
   # Clientes
   
	(1..3).each do |i|
        config.vm.define "Cliente#{i}" do |node|
            node.vm.hostname = "Cliente#{i}"
            node.vm.network "private_network", ip: "172.16.1.#{i+2}", netmask: "255.255.255.0", virtualbox__intnet: "E-ATP-CACHER-LAN"

            node.vm.provision "shell", inline: "echo Procesando cliente #{i}"
            node.vm.provision "shell", inline: "echo Monstrando a configuracion ip: && ip a"
            node.vm.provision "instala-apache",type: "shell", path: "scripts/clientes/install_apache.sh", run: "once"
            node.vm.provision "cambia-https",type: "shell", path: "scripts/clientes/cambiar-https.sh", run: "once"
            
	    node.vm.provision "shell", inline: "cp /vagrant/scripts/clientes/01apt-cacher-ng.conf /etc/apt/apt.conf.d/"
            
            node.vm.provision "shell", name: "cambia la puerta de enlace", path: "scripts/clientes/cambia-default-route-LAN.sh", run: "always"
            node.vm.provision "instala-anacrontab",type: "shell", path: "scripts/clientes/install-anacron.sh", run: "once"
            node.vm.provision "anacrontab",type: "shell", path: "scripts/clientes/anacrontab-clientes.sh", run: "always"

            node.vm.provider "virtualbox" do |vb|
                vb.name = "Cliente#{i}"
                vb.memory = "1024"
                vb.cpus = 1
                vb.linked_clone = true
                vb.customize ["modifyvm", :id, "--groups", "/Clientes"]
            end
        end
     end
end
