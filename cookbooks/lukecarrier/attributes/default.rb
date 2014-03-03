default['user']['name']    = 'Luke Carrier'
default['user']['email']   = 'luke@carrier.im'
default['user']['homedir'] = '/home/luke'
default['user']['login']   = 'luke'
default['user']['group']   = 'luke'
default['deploy_baseurl']  = 'http://deploy.lukecarrier.me/lukecarrier'

default['user']['applicationdir'] = File.join(default['user']['homedir'], '.local', 'applications')

default['redshift']['config'] = "#{default['deploy_baseurl']}/redshift/redshift.conf"

default['sublime_text']['license'] = "#{default['deploy_baseurl']}/sublime_text/License.sublime_license"

default['xchat']['servlist'] = "#{default['deploy_baseurl']}/xchat/servlist.conf"
