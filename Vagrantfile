Vagrant.configure("2") do |config|
    # Define the mono node
    config.vm.define "mono" do |mono|
      mono.vm.box = "centos/stream9"
      mono.vm.network "private_network", ip: "192.168.59.100"
      mono.vm.hostname = "mono"
      mono.vm.disk :disk, size: "40GB", primary: true
      mono.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = 2
      end
      mono.vm.provision "shell", inline: <<-SHELL
          # Update all packages
          sudo dnf update -y
        SHELL
    end

    # Define the opt node
    config.vm.define "opt" do |opt|
      opt.vm.box = "centos/stream9"
      opt.vm.network "private_network", ip: "192.168.59.101"
      opt.vm.hostname = "opt"
      opt.vm.disk :disk, size: "40GB", primary: true
      opt.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.cpus = 1
      end
      opt.vm.provision "shell", inline: <<-SHELL
          # Enable the EPEL repository on the system
          sudo dnf config-manager --set-enabled crb
          sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel{,-next}-release-latest-9.noarch.rpm

          # # Update all packages & Install Ansible
          sudo dnf update -y
          sudo dnf install -y ansible
        SHELL
    end
end