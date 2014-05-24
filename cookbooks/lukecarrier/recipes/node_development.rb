nvm_dir    = File.join(node['user']['homedir'], '.nvm')
nvm_source = ". #{nvm_dir}/nvm.sh"
nvm_node   = "0.10"

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
    #{nvm_source}
    nvm install #{nvm_node}
  EOF

  user  node['user']['login']
  group node['user']['group']
end

%w[cache prefix tmp].each do |key|
  path = File.join(node['user']['homedir'], '.npm', key)

  bash "npm config set #{key} #{path}" do
    code <<-EOF
      #{nvm_source}
      nvm use #{nvm_node}
      npm config set #{key} #{path}
    EOF

    environment({"USER" => node['user']['login'],
                 "HOME" => node['user']['homedir']})

    user  node['user']['login']
    group node['user']['group']
  end
end
