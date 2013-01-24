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

