phpbrew_global_root = '/opt/phpbrew'
phpbrew_global_bin  = File.join(phpbrew_global_root, 'bin')
phpbrew_global_app  = File.join(phpbrew_global_bin,  'phpbrew')

breweries = {
  node['user']['login'] => node['user']['homedir'],
  'root'                => '/root',
}

[ phpbrew_global_root, phpbrew_global_bin ].each do |directory_path|
  directory directory_path do
    user  'root'
    group 'root'
    mode  0755
  end
end

remote_file phpbrew_global_app do
  source 'https://github.com/phpbrew/phpbrew/raw/master/phpbrew'

  user  'root'
  group 'root'
  mode  0755
end

cookbook_file '/etc/profile.d/phpbrew.sh' do
  source 'phpbrew_profile'

  user  'root'
  group 'root'
  mode  0644
end

breweries.each do |login, home_dir|
  paths = {
    init: File.join(home_dir, '.phpbrew', 'init')
  }

  bash "phpbrew init for #{login}" do
    code <<-EOF
      #{phpbrew_global_app} init
    EOF

    environment({'HOME' => home_dir,
                 'USER' => login})

    user  login
    group login
  end

  cookbook_file paths[:init] do
    source 'phpbrew_init'

    user  login
    group login
    mode  0640
  end
end
