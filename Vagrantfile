# -*- mode: ruby -*-
# vi: set ft=ruby :


# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/xenial64"

  config.vm.hostname = "box"


  # SSH Agent Forwarding
  #
  # Enable agent forwarding on vagrant ssh commands. This allows you to use ssh keys
  # on your host machine inside the guest. See the manual for `ssh-add`.
  # config.ssh.forward_agent = true

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "private_network", type: "dhcp"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.synced_folder "~/projects", "/mnt/projects"
  config.vm.synced_folder "~/boxdrop", "/mnt/boxdrop"
  config.vm.synced_folder "~/boxstash", "/mnt/boxstash"

  # https://www.wildcardcorp.com/blog/making-vagrant-virtualbox-nfs-less-painful-with-sparse-disk-images
  # Only on `vagrant up` commands
  if ARGV[0] == "up" then
      # just convenience for not retyping long paths
      workspacepath = "./workspace"

      # Check to make sure the disk image exists (and create it if it doesn't)
      if not File.exists?("workspace.dmg.sparseimage")
          system 'hdiutil create "workspace.dmg.sparseimage" -type SPARSE -fs "Case-sensitive Journaled HFS+" -size 10g -volname "Workspace"'
      end

      # Mount the image, if it isn't mounted already
      system 'hdiutil attach "workspace.dmg.sparseimage"'

      # Create a symlink to the volume in the working directory of the Vagrantfile
      system 'ln -s "/Volumes/Workspace" "'+workspacepath+'"' unless File.exists?(workspacepath)

      # Mount the volume into the guest with NFS
      config.vm.synced_folder workspacepath, "/mnt/workspace", nfs: true

      # Disable the default /vagrant share (no need for it with the NFS share)
      #config.vm.synced_folder ".", "/vagrant", disabled: true
  end

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
   config.vm.provider "virtualbox" do |vb|
     # Display the VirtualBox GUI when booting the machine
     #vb.gui = true

     # Customize the amount of memory on the VM:
     vb.memory = "2048"
   end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL

  config.vm.provision "shell", inline: "apt-get --yes install make"
  config.vm.provision "shell", path: "./make.sh", args: ["root"]
  config.vm.provision "shell", path: "./make.sh", args: ["user"], privileged: false
end
