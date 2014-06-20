include_recipe 'lukecarrier::node_development'

git File.join(node['user']['applicationdir'], 'moosh') do
  repository 'https://github.com/tmuras/moosh.git'
  reference  'master'

  user  node['user']['login']
  group node['user']['login']
end

execute 'moosh composer install' do
  command 'composer install'

  environment({
    "PATH" => "#{node['user']['homedir']}/.local/bin:#{ENV['PATH']}"
  })

  cwd     File.join(node['user']['applicationdir'], 'moosh')
  user    node['user']['login']
  group   node['user']['group']
end

link File.join(node['user']['homedir'], '.local', 'bin', 'moosh') do
  to File.join(node['user']['applicationdir'], 'moosh', 'moosh.php')

  owner node['user']['login']
  group node['user']['group']
end

bash 'npm install -g shifter' do
  code <<-EOF
    export NODE_VERSION=#{node['node_development']['node_version']}
    #{node['user']['homedir']}/.nvm/nvm-exec npm install -g shifter
  EOF

  environment({"USER" => node['user']['login'],
               "HOME" => node['user']['homedir']})

  user  node['user']['login']
  group node['user']['group']
end
