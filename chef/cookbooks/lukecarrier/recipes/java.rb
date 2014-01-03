apt_repository 'oracle-java' do
  uri          'http://ppa.launchpad.net/webupd8team/java/ubuntu'
  distribution node['lsb']['codename']
  components   ['main']

  keyserver 'keyserver.ubuntu.com'
  key       'EEA14886'
end

execute 'debconf shared/accepted-oracle-license-v1-1 select true' do
  command 'echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections'
  returns 0
end

execute 'debconf shared/accepted-oracle-license-v1-1 seen true' do
  command 'echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections'
  returns 0
end

package 'oracle-java7-installer'
