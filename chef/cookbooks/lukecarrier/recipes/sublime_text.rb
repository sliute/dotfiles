config        = File.join(node['user']['homedir'], '.config', 'sublime-text-3')
license       = File.join(config, 'Local', 'License.sublime_license')
packages      = File.join(config, 'Installed Packages')
user_packages = File.join(config, 'Packages', 'User')

user_prefs = {
  "Preferences.sublime-settings"     => "user",
  "Package Control.sublime-settings" => "package_control",
}

apt_repository 'sublime-text' do
  uri          'http://ppa.launchpad.net/webupd8team/sublime-text-3/ubuntu'
  distribution node['lsb']['codename']
  components   ['main']

  keyserver 'keyserver.ubuntu.com'
  key       'EEA14886'
end

execute 'apt-get update' do
  command 'apt-get update >/dev/null'
  returns 0
end

package 'sublime-text-installer'

unless File.directory?(config)
  script 'subl --background' do
    interpreter 'bash'
    cwd         node['user']['homedir']
    user        node['user']['login']
    group       node['user']['group']

    code <<-EOF
      subl --background &
      sleep 2
      pkill subl
    EOF

    returns 0
  end
end

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

user_prefs.each do |target_file, source_file|
  cookbook_file File.join(user_packages, target_file) do
    source "sublime_text_#{source_file}_preferences"

    user  node['user']['login']
    group node['user']['group']
    mode  0640
  end
end
