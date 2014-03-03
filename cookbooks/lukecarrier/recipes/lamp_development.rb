packages = [
  'httpd', 'mod_suphp',
  'mariadb', 'mariadb-server',
  'php', 'php-cli', 'php-curl', 'php-intl', 'php-mbstring', 'php-mcrypt', 'php-mysql', 'php-xmlrpc',
  'phpmyadmin', 'w3m'
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

execute 'enable selinux httpd_enable_homedirs' do
  command 'setsebool -P httpd_enable_homedirs true'
end

execute 'enable selinux httpd_read_user_content' do
  command 'setsebool -P httpd_read_user_content true'
end

execute 'enable selinux httpd_unified' do
  command 'setsebool -P httpd_unified true'
end

service 'httpd' do
  action [:enable, :start]
end

service 'mariadb' do
  action [:enable, :start]
end

cookbook_file File.join(node['user']['homedir'], '.bash_profile.d', 'a2status') do
  source 'bash_profile_a2status'

  owner node['user']['login']
  group node['user']['group']
  mode  0644
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
