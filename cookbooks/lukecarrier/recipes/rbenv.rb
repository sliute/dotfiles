git File.join(node['user']['homedir'], '.rbenv') do
  repository 'https://github.com/sstephenson/rbenv.git'
  reference 'master'

  user  node['user']['login']
  group node['user']['group']
end

directory File.join(node['user']['homedir'], '.rbenv', 'plugins') do
  owner node['user']['login']
  group node['user']['group']
  mode  0755
end

git File.join(node['user']['homedir'], '.rbenv', 'plugins', 'ruby-build') do
  repository 'https://github.com/sstephenson/ruby-build.git'
  reference 'master'

  user  node['user']['login']
  group node['user']['group']
end

cookbook_file File.join(node['user']['homedir'], '.bash_profile.d', 'rbenv') do
  source 'bash_profile_rbenv'

  owner node['user']['login']
  group node['user']['group']
  mode  0644
end
