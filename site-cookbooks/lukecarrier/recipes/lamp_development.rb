packages = [
  'httpd', 'mod_suphp',
  'mariadb', 'mariadb-server',
  'php', 'php-cli', 'php-curl', 'php-intl', 'php-mbstring', 'php-mcrypt', 'php-mysql', 'php-opcache', 'php-pgsql', 'php-soap', 'php-xmlrpc', 'php-zip',
  'php-pecl-xdebug',
  'phpmyadmin', 'w3m',
  'postgresql', 'postgresql-server'
]

packages.each {|name| package name}

file '/etc/httpd/conf.d/welcome.conf' do
  action :delete
end

cookbook_file '/etc/httpd/conf.d/mod_suphp.conf' do
  source 'lamp_development_suphp.conf'

  owner 'root'
  group 'root'
  mode 0644
end

cookbook_file '/etc/httpd/conf.d/php.conf' do
  source 'lamp_development_php.conf'

  owner 'root'
  group 'root'
  mode 0644
end

cookbook_file '/etc/httpd/conf.d/userdir.conf' do
  source 'lamp_development_userdir.conf'

  owner 'root'
  group 'root'
  mode 0644
end

cookbook_file '/etc/suphp.conf' do
  source 'suphp.conf'

  owner 'root'
  group 'root'
  mode  0644
end

execute 'postgresql-setup initdb' do
  not_if { ::File.exists? '/var/lib/pgsql/initdb.log' }
end

cookbook_file '/var/lib/pgsql/data/pg_hba.conf' do
  source 'lamp_development_pg_hba.conf'

  user  'root'
  group 'root'
  mode  0644
end

%w{ can_network_connect can_network_connect_db can_sendmail enable_homedirs read_user_content unified }.each do |key|
  execute "enable selinux httpd_#{key}" do
    command "setsebool -P httpd_#{key} true"
  end
end

%w{ httpd mariadb postgresql }.each do |service_name|
  service service_name do
    action [:enable, :restart]
  end
end

bash_profile_files = ['a2status', 'composer']
bash_profile_files.each do |file|
  cookbook_file File.join(node['user']['homedir'], '.bash_profile.d', file) do
    source "bash_profile_#{file}"

    owner node['user']['login']
    group node['user']['group']
    mode  0644
  end
end

directory node['user']['homedir'] do
  owner node['user']['login']
  group node['user']['group']
  mode  0711
end

directory File.join(node['user']['homedir'], 'Sites') do
  owner node['user']['login']
  group node['user']['group']
  mode  0755
end

remote_file File.join(node['user']['homedir'], '.local', 'bin', 'composer') do
  source 'http://getcomposer.org/composer.phar'

  owner node['user']['login']
  group node['user']['group']
  mode  0755
end

git File.join(node['user']['applicationdir'], 'psysh') do
  repository 'https://github.com/bobthecow/psysh.git'
  revision 'master'

  user  node['user']['login']
  group node['user']['group']
end

execute 'psysh composer install' do
  command 'composer install'

  environment({
    "PATH" => "#{node['user']['homedir']}/.local/bin:#{ENV['PATH']}"
  })

  cwd   File.join(node['user']['applicationdir'], 'psysh')
  user  node['user']['login']
  group node['user']['group']
end

cookbook_file File.join(node['user']['homedir'], '.bash_profile.d', 'psysh') do
  source 'bash_profile_psysh'

  owner node['user']['login']
  group node['user']['group']
  mode 0644
end

log 'Now run mysql_secure_installation' do
  level :warn
end
