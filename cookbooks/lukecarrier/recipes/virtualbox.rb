remote_file '/etc/yum.repos.d/virtualbox.repo' do
  source 'http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo'

  owner 'root'
  group 'root'
  mode  0644
end

%w[dkms VirtualBox-4.3].each {|name| package name}

execute 'service vboxdrv setup'
execute "usermod -aG vboxusers #{node['user']['login']}"
