package 'libapache2-mod-php5'
package 'libapache2-mod-suphp'
package 'mysql-client'
package 'mysql-server'
package 'php5'
package 'php5-cli'
package 'php5-curl'
package 'php5-intl'
package 'php5-mysql'
package 'php5-xmlrpc'
package 'phpmyadmin'

execute 'enable mod_php5' do
  command 'a2enmod php5'
end

execute 'enable mod_suphp' do
  command 'a2enmod suphp'
end

execute 'enable mod_userdir' do
  command 'a2enmod userdir'
end

cookbook_file '/etc/apache2/mods-available/php5.conf' do
  source 'mod_php5.conf'

  owner 'root'
  group 'root'
  mode 0644
end

cookbook_file '/etc/suphp/suphp.conf' do
  source 'suphp.conf'

  owner 'root'
  group 'root'
  mode 0644
end

cookbook_file '/etc/apache2/mods-available/suphp.conf' do
  source 'mod_suphp.conf'

  owner 'root'
  group 'root'
  mode 0644
end

cookbook_file '/etc/apache2/mods-available/userdir.conf' do
  source 'mod_userdir.conf'

  owner 'root'
  group 'root'
  mode 644
end

service 'apache2' do
  action :restart
end
