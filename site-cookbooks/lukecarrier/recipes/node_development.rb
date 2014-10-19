nvm_dir    = File.join(node['user']['homedir'], '.nvm')
nvm_source = ". #{nvm_dir}/nvm.sh"

package 'nodejs'

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

bash "nvm install #{node['node_development']['node_version']}" do
  code <<-EOF
    #{nvm_source}
    nvm install #{node['node_development']['node_version']}
  EOF

  user  node['user']['login']
  group node['user']['group']
end

npm_dir  = File.join node['user']['homedir'], '.npm'
npm_keys = %w[cache prefix tmp]

npm_dirs = [npm_dir] + npm_keys.map {|key| File.join(npm_dir, key) }
npm_dirs.each do |dir|
  directory dir do
    owner node['user']['login']
    group node['user']['group']
    mode  0750
  end
end

npm_keys.each do |key|
  path = File.join(npm_dir, key)

  bash "npm config set #{key} #{path}" do
    code <<-EOF
      #{nvm_source}
      nvm use #{node['node_development']['node_version']}
      npm config set #{key} #{path}
    EOF

    environment({"USER" => node['user']['login'],
                 "HOME" => node['user']['homedir']})

    user  node['user']['login']
    group node['user']['group']
  end
end

# Bump the log level so we know it's actually doing something
bash "npm config set loglevel http" do
  code <<-EOF
    #{nvm_source}
    nvm use #{node['node_development']['node_version']}
    npm config set loglevel http
  EOF

  environment({"USER" => node['user']['login'],
               "HOME" => node['user']['homedir']})

  user  node['user']['login']
  group node['user']['group']
end

# Work around for broken node-gyp and upstream gyp
bash "npm config set python /usr/bin/python2" do
  code <<-EOF
    #{nvm_source}
    nvm use #{node['node_development']['node_version']}
    npm config set python /usr/bin/python2
  EOF

  environment({"USER" => node['user']['login'],
               "HOME" => node['user']['homedir']})

  user  node['user']['login']
  group node['user']['group']
end
