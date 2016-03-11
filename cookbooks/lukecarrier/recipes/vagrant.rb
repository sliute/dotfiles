# Vagrant

include_recipe 'vagrant::default'

if node['platform_family'] == 'windows'
  windows_path 'C:\HashiCorp\Vagrant\bin' do
    action :add
  end
end
