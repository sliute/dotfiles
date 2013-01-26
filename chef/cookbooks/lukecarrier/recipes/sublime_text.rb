apt_repository 'sublime-text' do
  uri          'http://ppa.launchpad.net/webupd8team/sublime-text-2/ubuntu'
  distribution node['lsb']['codename']
  components   ['main']

  keyserver 'keyserver.ubuntu.com'
  key       'EEA14886'
end

execute 'apt-get update' do
  command 'apt-get update >/dev/null'
  returns 0
end

package 'sublime-text'

script 'sublime-text --background' do
  interpreter 'bash'
  cwd         node['user']['homedir']
  user        node['user']['login']
  group       node['user']['group']

  code <<-EOF
    sublime-text --background &
    sleep 2
    pkill sublime_text
  EOF

  returns 0
end

config   = File.join(node['user']['homedir'], '.config', 'sublime-text-2')
license  = File.join(config, 'Settings', 'License.sublime_license')
packages = File.join(config, 'Installed Packages')

remote_file File.join(packages, 'Package Control.sublime-package') do
  action :create_if_missing
  source 'http://sublime.wbond.net/Package%20Control.sublime-package'

  owner node['user']['login']
  group node['user']['group']
  mode  0644
end

if node['sublime_text']['license'].length > 0
  remote_file license do
    action :create_if_missing
    source node['sublime_text']['license']

    user  node['user']['login']
    group node['user']['group']
    mode  0640
  end
end

