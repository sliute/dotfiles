apt_repository 'chrislea-node' do
  uri          'http://ppa.launchpad.net/chris-lea/node.js/ubuntu'
  distribution node['lsb']['codename']
  components   ['main']

  keyserver 'keyserver.ubuntu.com'
  key       'C7917B12'
end

package 'nodejs'

execute 'install shifter' do
  command 'npm -g install shifter'
end
