directory File.join(node['user']['homedir'], '.bash_profile.d') do
  owner node['user']['login']
  group node['user']['group']
  mode  0755
end

file File.join(node['user']['homedir'], '.bash_profile.d', '_') do
  action :touch

  owner node['user']['login']
  group node['user']['group']
  mode  0644
end

cookbook_file File.join(node['user']['homedir'], '.bash_profile') do
  owner node['user']['login']
  group node['user']['group']
  mode  0644

  source 'bash_profile'
end
