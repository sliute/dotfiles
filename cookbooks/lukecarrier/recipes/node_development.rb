nvm_dir = File.join(node['user']['homedir'], '.nvm')

git nvm_dir do
  repository 'https://github.com/creationix/nvm.git'
  reference 'master'

  user  node['user']['login']
  group node['user']['group']
end

cookbook_file File.join(node['user']['homedir'], '.bash_profile.d', 'nvm') do
  source 'bash_profile_nvm'

  owner node['user']['login']
  group node['user']['group']
  mode  0644
end

bash "nvm install 0.10" do
  code <<-EOF
    . #{nvm_dir}/nvm.sh
    nvm install 0.10
  EOF

  user  node['user']['login']
  group node['user']['group']
end
