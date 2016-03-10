# Git SCM

include_recipe 'git'

template File.join(node['user']['homedir'], '.gitconfig') do
  source 'gitconfig.erb'
  variables ({
    user_email:   node['user']['email'],
    user_homedir: node['user']['homedir'],
    user_name:    node['user']['name'],
  })

  owner node['user']['login']
  group node['user']['group']
  mode 0640
end

cookbook_file File.join(node['user']['homedir'], '.gitignore') do
  source 'gitignore'

  owner node['user']['login']
  group node['user']['group']
  mode  0644
end

case node['platform_family']
when 'debian'
  link '/etc/profile.d/git-prompt.sh' do
    to '/usr/share/git-core/contrib/completion/git-prompt.sh'
  end
when 'windows'
  windows_path node['git']['cmd_path'] do
    action :add
  end
end
