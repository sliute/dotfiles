package 'git-all'

template File.join(node['user']['homedir'], '.gitconfig') do 
  source 'gitconfig.erb'
  variables({
    :user_email   => node['user']['email'],
    :user_homedir => node['user']['homedir'],
    :user_name    => node['user']['name']
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
