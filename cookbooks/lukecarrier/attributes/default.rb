# Information about your user account.
#
# Used to generate paths to things, your Git configuration and a bunch of
# permissions when altering your configuration files.
default['user']['name']           = 'Luke Carrier'
default['user']['email']          = 'luke@carrier.im'
default['user']['login']          = 'luke'
default['user']['group']          = 'luke'
default['user']['homedir']        = "/home/#{default['user']['login']}"
default['user']['applicationdir'] = "#{node['user']['homedir']}/.local/applications"
default['user']['bindir']         = "#{node['user']['homedir']}/.local/bin"

if node['platform_family'] == 'windows'
  default['user']['homedir'] = "C:\Users\#{node['user']['login']}"
end

# The version of Git to install (Windows only)
if node['platform_family'] == 'windows'
  default['git']['version']      = '2.7.2'
  default['git']['architecture'] = '64'
  default['git']['checksum']     = 'ec4009b36ce855ab262f999030fff5471de73cf0071202138d395648756c7e8b'
  default['git']['cmd_path']     = 'C:\Program Files\Git\cmd'
end

# Jetbrains Toolbox app
default['jetbrains_toolbox']['version'] = '1.1.2143'
if node['platform_family'] == 'debian'
  default['jetbrains_toolbox']['url']      = "https://download-cf.jetbrains.com/toolbox/jetbrains-toolbox-#{node['jetbrains_toolbox']['version']}.tar.gz"
  default['jetbrains_toolbox']['checksum'] = "74ca89a1b97367e909075e53c67ee093ca316ecb8124bb39e7318750634552a3"
elsif node['platform_family'] == 'windows'
  default['jetbrains_toolbox']['url'] = "https://download.jetbrains.com/toolbox/jetbrains-toolbox-#{node['jetbrains_toolbox']['version']}.exe"
end

# Install nvm under the user account, with these node versions
if node['platform_family'] == 'debian'
  default['node_development']['directory']     = File.join(default['user']['homedir'], '.nvm')
  default['node_development']['profile_file']  = File.join(default['user']['homedir'], '.bash_profile.d', 'nvm')
  default['node_development']['node_versions'] = [
    '6.9.5',
    '7.5.0',
  ]
end

# KeePassX version to install (Windows only)
if node['platform_family'] == 'windows'
  default['keepassx']['version'] = '2.0.2'
  default['keepassx']['install_dir'] = 'C:\Program Files (x86)\KeePassX'
end

# VirtualBox installation source
case node['platform_family']
when 'debian'
  default['virtualbox']['version'] = '5.0'
when 'windows'
  default['virtualbox']['url'] = 'http://download.virtualbox.org/virtualbox/5.0.16/VirtualBox-5.0.16-105871-Win.exe'
end
