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

# The version of NodeJS to install and use by default.
#
# Some recipes (i.e. moodle_development) require Node and NPM to be available
# when they run, so we need to tell them which version to use. You're of course
# welcome to install additional nodes using NVM after the installation has
# completed.
default['node_development']['node_version'] = '0.10'

# Path to files used for deployment.
#
# The following files contain sensitive information and are not made available
# in this repository:
#
# - redshift/redshift.conf (contains latitude/longitude information)
# - sublime_text/License.sublime-license (get your own)
# - xchat/servlist.conf (IRC server credentials)
#
# These URLs can be in any format that Chef's remote_file resource will
# understand.
default['deploy_baseurl']  = 'http://deploy.lukecarrier.me/lukecarrier'

default['redshift']['config'] = "#{default['deploy_baseurl']}/redshift/redshift.conf"
default['sublime_text']['license'] = "#{default['deploy_baseurl']}/sublime_text/License.sublime_license"
default['xchat']['servlist'] = "#{default['deploy_baseurl']}/xchat/servlist.conf"
