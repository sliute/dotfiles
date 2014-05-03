package 'nodejs'
package 'npm'

node_env = { "HOME" => node['user']['homedir'],
             "USER" => node['user']['login'] }

execute 'npm config set cache' do
  command "npm config set cache #{node['user']['homedir']}/.npm/cache"

  environment node_env

  user  node['user']['login']
  group node['user']['group']
end

execute 'npm config set prefix' do
  command "npm config set prefix #{node['user']['homedir']}/.npm/prefix"

  environment node_env

  user  node['user']['login']
  group node['user']['group']
end

execute 'npm config set tmp' do
  command "npm config set tmp #{node['user']['homedir']}/.npm/tmp"

  environment node_env

  user  node['user']['login']
  group node['user']['group']
end

cookbook_file File.join(node['user']['homedir'], '.bash_profile.d', 'npm') do
  source 'bash_profile_npm'

  owner node['user']['login']
  group node['user']['group']
  mode  0644
end
