package 'gtk-redshift'

remote_file File.join(node['user']['homedir'], '.config', 'redshift.conf') do
  action :create_if_missing
  source node['redshift']['config']

  owner node['user']['login']
  group node['user']['group']
  mode  0644
end
