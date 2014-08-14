# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise64"
  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 512, "--ioapic", "on", "--cpus", 1]
  end

  start_script = <<-eos
    if [ ! -f /usr/local/bin/librarian-puppet ]; then
      rm -rf /opt/vagrant_ruby/
      wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
      dpkg -i puppetlabs-release-precise.deb
      apt-get update -y && apt-get -y install puppet
      apt-get -y install make ruby1.9.3
      gem install librarian-puppet -v "1.3.1"
      cd /vagrant/puppet
      mkdir -p /etc/puppet/modules
      touch /etc/puppet/hiera.yaml
      mkdir -p /var/lib/hiera/
      touch /var/lib/hiera/common.yaml
    fi
    export LIBRARIAN_PUPPET_PATH=/etc/puppet/modules
    export LIBRARIAN_PUPPET_TMP=/tmp
    librarian-puppet install
  eos

  config.vm.provision :shell, :inline => start_script

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "tp-client.pp"
    puppet.module_path    = ['puppet/modules']
  end

end
