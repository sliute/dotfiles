config             = File.join(node['user']['homedir'], '.config', 'sublime-text-3')
local              = File.join(config,   'Local')
license            = File.join(local,    'License.sublime_license')
installed_packages = File.join(config,   'Installed Packages')
packages           = File.join(config,   'Packages')
user_packages      = File.join(packages, 'User')

user_prefs = {
  'Preferences.sublime-settings'     => 'user',
  'Package Control.sublime-settings' => 'package_control',
}

package 'sublime-text-installer'

[config, installed_packages, local, packages, user_packages].each do |dir|
  directory dir do
    owner node['user']['login']
    group node['user']['group']
    mode  0750
  end
end

remote_file File.join(installed_packages, 'Package Control.sublime-package') do
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
