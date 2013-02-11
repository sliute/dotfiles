apt_repository 'oracle-vm-virtualbox' do
  uri          'http://download.virtualbox.org/virtualbox/debian'
  distribution node['lsb']['codename']
  components   ['contrib']

  keyserver 'pgp.mit.edu'
  key       '98AB5139'
end

execute 'apt-get update' do
  command 'apt-get update >/dev/null'
  returns 0
end

package 'dkms'
package 'virtualbox-4.2'
