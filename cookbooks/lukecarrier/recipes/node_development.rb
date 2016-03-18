# nvm and node

if node['platform_family'] == 'debian'
  nvm_ng_install node['node_development']['directory'] do
    user  node['user']['login']
    group node['user']['group']

    profile_file node['node_development']['profile_file']
  end

  node['node_development']['node_versions'].each do |version|
    nvm_ng_node_install version do
      nvm_name node['node_development']['directory']
    end
  end
end
