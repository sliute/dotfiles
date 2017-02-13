include_recipe 'lukecarrier::homedir'

packages = [
  'php7.0-cli', 'php7.0-phpdbg',

  'php7.0-dev',

  'snmp',

  'php7.0-bcmath', 'php7.0-bz2', 'php7.0-curl', 'php7.0-dba', 'php7.0-enchant',
  'php7.0-gd', 'php7.0-gmp', 'php7.0-imap', 'php7.0-interbase', 'php7.0-intl',
  'php7.0-json', 'php7.0-ldap', 'php7.0-mbstring', 'php7.0-mcrypt',
  'php7.0-mysql', 'php7.0-odbc', 'php7.0-opcache', 'php7.0-pgsql',
  'php7.0-pspell', 'php7.0-readline', 'php7.0-recode', 'php7.0-snmp',
  'php7.0-soap', 'php7.0-sqlite3', 'php7.0-sybase', 'php7.0-tidy', 'php7.0-xml',
  'php7.0-xmlrpc', 'php7.0-xsl', 'php7.0-zip',
]
packages.each {|name| package name}

bash_profile_files = ['composer', 'psysh']
bash_profile_files.each do |file|
  cookbook_file File.join(node['user']['homedir'], '.bash_profile.d', file) do
    source "bash_profile_#{file}"

    owner node['user']['login']
    group node['user']['group']
    mode  0600
  end
end

directory File.join(node['user']['homedir'], '.local', 'bin') do
  owner node['user']['login']
  group node['user']['group']
  mode  0700
end

remote_file File.join(node['user']['homedir'], '.local', 'bin', 'composer') do
  source 'http://getcomposer.org/composer.phar'

  owner node['user']['login']
  group node['user']['group']
  mode  0700
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
    'PATH' => "#{node['user']['homedir']}/.local/bin:#{ENV['PATH']}"
  })

  cwd   File.join(node['user']['applicationdir'], 'psysh')
  user  node['user']['login']
  group node['user']['group']
end
