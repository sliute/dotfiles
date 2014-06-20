package 'mosh'

cookbook_file File.join(node['user']['homedir'], '.bash_profile.d', 'mosh') do
  source 'bash_profile_mosh'

  owner node['user']['login']
  group node['user']['group']
  mode  0644
end
