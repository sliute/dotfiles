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

# The version of NodeJS to install and use by default.
#
# Some recipes (i.e. moodle_development) require Node and NPM to be available
# when they run, so we need to tell them which version to use. You're of course
# welcome to install additional nodes using NVM after the installation has
# completed.
default['node_development']['node_version'] = '0.11'

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

# Install VirtualBox 5.0 from the Oracle repository.
default['virtualbox']['version'] = '5.0'
