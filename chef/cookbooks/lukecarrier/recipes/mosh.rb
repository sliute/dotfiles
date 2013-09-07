apt_repository 'mosh' do
  uri          'http://ppa.launchpad.net/keithw/mosh/ubuntu'
  distribution node['lsb']['codename']
  components   ['main']

  keyserver 'keyserver.ubuntu.com'
  key       '7BF6DFCD'
end

package 'mosh'

cookbook_file File.join(node['user']['homedir'], '.bash_profile.d', 'mosh') do
  source 'bash_profile_mosh'

  owner node['user']['login']
  group node['user']['group']
  mode  0644
end
