# Information about your user account.
#
# Used to generate paths to things, your Git configuration and a bunch of
# permissions when altering your configuration files.
default['user']['name']           = 'Luke Carrier'
default['user']['email']          = 'luke@carrier.im'
default['user']['homedir']        = '/home/luke'
default['user']['login']          = 'luke'
default['user']['group']          = 'luke'
default['user']['applicationdir'] = File.join(default['user']['homedir'], '.local', 'applications')

if node['platform_family'] == 'windows'
  default['user']['login']   = 'lcarrier'
  default['user']['group']   = 'lcarrier'
  default['user']['homedir'] = 'C:\Users\lcarrier'
end

# The version of Git to install (Windows only)
default['git']['version']      = '2.7.2'
default['git']['architecture'] = '64'
default['git']['checksum']     = 'ec4009b36ce855ab262f999030fff5471de73cf0071202138d395648756c7e8b'
default['git']['cmd_path']     = 'C:\Program Files\Git\cmd'

# Install nvm under the user account, with these node versions
default['node_development']['directory']     = File.join(default['user']['homedir'], '.nvm')
default['node_development']['profile_file']  = File.join(default['user']['homedir'], '.bash_profile.d', 'nvm')
default['node_development']['node_versions'] = [
  '0.12.12',
  '5.8.0',
]

# Path to files used for deployment.
#
# The following files contain sensitive information and are not made available
# in this repository:
#
# - redshift/redshift.conf (contains latitude/longitude information)
# - xchat/servlist.conf (IRC server credentials)
#
# These URLs can be in any format that Chef's remote_file resource will
# understand.
default['deploy_baseurl']  = 'http://deploy.lukecarrier.me/lukecarrier'

default['redshift']['config'] = "#{default['deploy_baseurl']}/redshift/redshift.conf"
default['xchat']['servlist'] = "#{default['deploy_baseurl']}/xchat/servlist.conf"

# KeePassX version to install (Windows only)
default['keepassx']['version'] = '2.0.2'
default['keepassx']['install_dir'] = 'C:\Program Files (x86)\KeePassX'

# VirtualBox installation source
case node['platform_family']
when 'debian'
  default['virtualbox']['version'] = '5.0'
when 'windows'
  default['virtualbox']['url'] = 'http://download.virtualbox.org/virtualbox/5.0.16/VirtualBox-5.0.16-105871-Win.exe'
end
