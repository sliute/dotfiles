apt_repository 'owncloud-client' do
  uri          'http://download.opensuse.org/repositories/isv:ownCloud:devel/xUbuntu_13.04'
  distribution '/'

  keyserver 'pgp.mit.edu'
  key       'BA684223'
end

execute 'apt-get update' do
  command 'apt-get update >/dev/null'
  returns 0
end

package 'owncloud-client'
