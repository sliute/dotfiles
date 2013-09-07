apt_repository 'mosh' do
  uri          'http://ppa.launchpad.net/keithw/mosh/ubuntu'
  distribution node['lsb']['codename']
  components   ['main']

  keyserver 'keyserver.ubuntu.com'
  key       '7BF6DFCD'
end

package 'mosh'
