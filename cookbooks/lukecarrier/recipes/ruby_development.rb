rbenv_plugins = [
  {
    name: 'ruby-build',
    repo: 'https://github.com/sstephenson/ruby-build.git',
  },
  {
    name: 'rbenv-update',
    repo: 'https://github.com/rkh/rbenv-update.git',
  },
]

git File.join(node['user']['homedir'], '.rbenv') do
  repository 'https://github.com/sstephenson/rbenv.git'
  revision 'master'

  user  node['user']['login']
  group node['user']['group']
end

directory File.join(node['user']['homedir'], '.rbenv', 'plugins') do
  owner node['user']['login']
  group node['user']['group']
  mode  0755
end

rbenv_plugins.each do |plugin|
  git File.join(node['user']['homedir'], '.rbenv', 'plugins', plugin[:name]) do
    repository plugin[:repo]
    revision 'master'

    user  node['user']['login']
    group node['user']['group']
  end
end

cookbook_file File.join(node['user']['homedir'], '.bash_profile.d', 'rbenv') do
  source 'bash_profile_rbenv'

  owner node['user']['login']
  group node['user']['group']
  mode  0644
end
