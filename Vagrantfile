Vagrant.configure(2) do |config|

  config.vm.define "apprenda-windows", primary: true do |node|
    node.vm.box = 'apprenda/windows2012r2'
    node.vm.communicator = 'winrm'
    node.vm.network 'forwarded_port', host: 33199, guest: 3389
    node.vm.network 'private_network', ip: '172.16.0.10'
    node.vm.hostname = 'apprwin'
    node.vm.provider :virtualbox do |vb|
      vb.name = 'apprwin'
      vb.gui = false
      vb.memory = 4096
    end
    node.vm.provision 'file', source: './certs/root.cer', destination: 'C:\\users\\vagrant\\root.cer'
    node.vm.provision 'file', source: './certs/apprendassl.pfx', destination: 'C:\\users\\vagrant\\apprendassl.pfx'
    node.vm.provision 'chef_solo' do |chef|
      chef.cookbooks_path = ['chef/berks-cookbooks', 'chef/cookbooks']
      chef.json = {
        'sql_server' => {
          'accept_eula' => true,
          'server_sa_password' => 'bxcr@dm!Npaas',
          'version' => '2016',
          'instance_name' => 'MSSQLSERVER',
          'update_enabled' => false
        }
      }
      chef.add_recipe "sql_server::server"
      chef.add_recipe "apprenda::setup"
    end
    node.vm.provision 'shell', path: "./scripts/ps/Configure-SQL.ps1"
    node.vm.provision 'shell', path: "./scripts/ps/Download-Apprenda.ps1"
    node.vm.provision 'shell', path: "./scripts/ps/Install-Apprenda.ps1"
  end

  config.vm.define "apprenda-linux", autostart: false do |node|
    node.vm.box = 'bento/centos-7.3'
    node.vm.hostname = 'apprlin'
    node.vm.network 'private_network', ip: '172.16.0.11'
    node.vm.provider :virtualbox do |vb|
      vb.name = 'apprlin'
      vb.memory = 2048
    end

    node.vm.provision 'chef_solo' do |chef|
      chef.cookbooks_path = ['chef/berks-cookbooks', 'chef/cookbooks']
      chef.json = {
        'apprenda_linux' => {
          'hostname' => 'apprlin',
          'loadmanagerip' => '172.16.0.10',
          'loadmanagerhostname' => 'apprwin'
        }
      }
      chef.add_recipe "apprenda_linux::centos7"
      chef.add_recipe "apprenda_linux::docker"
    end
    node.vm.provision 'shell', path: './scripts/sh/installapprenda.sh'
  end

  config.vm.define "apprenda-k8s", autostart: false do |node|
    node.vm.box = 'bento/centos-7.3'
    node.vm.hostname = 'apprk8s'
    node.vm.network 'private_network', ip: '172.16.0.12'
    node.vm.network 'forwarded_port', host: 8080, guest: 8080
    node.vm.network 'forwarded_port', host: 6443, guest: 6443
    node.vm.provider :virtualbox do |vb|
      vb.name = 'apprk8s'
      vb.memory = 2048
    end
    node.vm.provision 'chef_solo' do |chef|
      chef.cookbooks_path = ['chef/berks-cookbooks', 'chef/cookbooks']
      chef.json = {
        'apprenda_linux' => {
          'hostname' => 'apprk8s',
          'loadmanagerip' => '172.16.0.10',
          'loadmanagerhostname' => 'apprwin'
        }
      }
      chef.add_recipe "apprenda_linux::centos7"
    end
    node.vm.provision "file", source: './files/kismatic-cluster.yaml', destination: '~/kismatic-cluster.yaml'
    node.vm.provision "file", source: './certs/root.cer', destination: '~/ca.pem'
    node.vm.provision "file", source: './certs/privkey.pem', destination: '~/ca-key.pem'
    node.vm.provision 'shell', path: './scripts/sh/movecerts.sh'
    node.vm.provision 'shell', path: './scripts/sh/installkismatic.sh', privileged: true
    node.vm.provision 'shell', path: './scripts/sh/joincluster.sh'
  end
end