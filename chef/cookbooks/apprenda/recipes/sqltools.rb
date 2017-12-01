chocolatey_package 'sqlserver-odbcdriver' do
  action :install
  version '13.1.4413.46'
end

powershell_script "install cmdlineutils" do
  code <<-EOH
  choco install sqlserver-cmdlineutils -y
  choco install sql2016-smo -y
  exit 0
  EOH
end

powershell_script "configure remoting for sql server" do
  code <<-EOH
  import-module "sqlps"
  $smo = 'Microsoft.SqlServer.Management.Smo.'
  $wmi = new-object ($smo + 'Wmi.ManagedComputer').
  
  # List the object properties, including the instance names.
  $Wmi
  
  # Enable the named pipes protocol for the default instance.
  $uri = "ManagedComputer[@Name='" + (get-item env:\\computername).Value + "']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Np']"
  $Np = $wmi.GetSmoObject($uri)
  $Np.IsEnabled = $true
  $Np.Alter()
  $Np

  # Enable the TCP protocol on the default instance.
  $uri = "ManagedComputer[@Name='" + (get-item env:\\computername).Value + "']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']"
  $Tcp = $wmi.GetSmoObject($uri)
  $Tcp.IsEnabled = $true
  $Tcp.Alter()
  $Tcp
  
  Restart-Service -Force MSSQLSERVER
  
  exit 0
  EOH
end