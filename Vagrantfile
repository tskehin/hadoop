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

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/xenial64"

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
  #config.vm.network "forwarded_port", guest: 22, host: 2202, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 9000, host: 9000, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 50070, host: 50070, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 50075, host: 50075, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 8088, host: 8088, host_ip: "127.0.0.1"

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
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
    vb.memory = "4096"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL

  # provision hadoop and java
  config.vm.provision "hadoop", type: "shell" do |shell|
    shell.inline = <<-SHELL

    echo "update system"
    apt-get update
    apt-get dist-upgrade -y

    echo "install java"
    apt-get install default-jdk -y
    echo "\nJAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")" >> /etc/environment
    source /etc/environment

    echo "get hadoop and install"
    wget http://ftp.heanet.ie/mirrors/www.apache.org/dist/hadoop/common/stable/hadoop-2.9.0.tar.gz

    tar -xzvf hadoop-2.9.0.tar.gz
    rm -rf /usr/local/hadoop
    mv hadoop-2.9.0 /usr/local/hadoop
    chmod -R 777 /usr/local/hadoop

    rm -f hadoop-2.9.0.tar.gz
    
    echo "\nHADOOP_HOME=/usr/local/hadoop" >> /etc/environment
    source /etc/environment

    echo "\nexport JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")" >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh

    SHELL
  end
  
  # provision python and mapreduce
  config.vm.provision "python", type: "shell" do |shell|
    shell.inline = <<-SHELL

    echo "update system"
    apt-get update
    apt-get dist-upgrade -y

    echo "install python3"
    apt-get install python3 -y
    apt-get install python3-pip -y

    pip3 install --upgrade pip
    pip3 install mrjob
    pip3 install mr3px
    SHELL
  end

  # provision the files required
  config.vm.provision "src", type: "file" do |file|
    file.source = "./src"
    file.destination = "~/src"
  end

  # provision the data required
  config.vm.provision "data", type: "file" do |file|
    file.source = "./data"
    file.destination = "~/data"
  end

  # provision pig
  config.vm.provision "pig", type: "shell" do |shell|
    shell.inline = <<-SHELL

    echo "update system"
    apt-get update
    apt-get dist-upgrade -y

    echo "get pig and install"
    wget http://ftp.heanet.ie/mirrors/www.apache.org/dist/pig/pig-0.17.0/pig-0.17.0.tar.gz 

    tar -xzvf pig-0.17.0.tar.gz 
    rm -rf /usr/local/pig
    mv pig-0.17.0 /usr/local/pig
    chmod -R 777 /usr/local/pig

    rm -f pig-0.17.0.tar.gz 
    
    echo "\nPIG_HOME=/usr/local/pig" >> /etc/environment
    source /etc/environment

    SHELL
  end 

  # provision hive
  config.vm.provision "hive", type: "shell" do |shell|
    shell.inline = <<-SHELL

    echo "update system"
    apt-get update
    apt-get dist-upgrade -y

    echo "get hive and install"
    wget http://ftp.heanet.ie/mirrors/www.apache.org/dist/hive/stable-2/apache-hive-2.3.2-bin.tar.gz 

    tar -xzvf apache-hive-2.3.2-bin.tar.gz
    rm -rf /usr/local/hive
    mv apache-hive-2.3.2-bin /usr/local/hive
    chmod -R 777 /usr/local/hive

    rm -f apache-hive-2.3.2-bin.tar.gz
    
    echo "\nHIVE_HOME=/usr/local/hive" >> /etc/environment
    source /etc/environment

    cp $HIVE_HOME/conf/hive-env.sh.template $HIVE_HOME/conf/hive-env.sh
    cp $HIVE_HOME/conf/hive-default.xml.template $HIVE_HOME/conf/hive-site.xml

    echo "\nexport HADOOP_HOME=$HADOOP_HOME" >> $HIVE_HOME/conf/hive-env.sh

    SHELL
  end 

  # updating PATH
  config.vm.provision "path", type: "shell" do |shell|
    shell.inline = <<-SHELL

    echo "\nexport PATH=$PATH:$HADOOP_HOME/bin:$PIG_HOME/bin:$HIVE_HOME/bin" >> /home/vagrant/.profile
    source /home/vagrant/.profile

    SHELL
  end 

end