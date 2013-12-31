ppas          = %w[gnome3 gnome3-next gnome3-staging]
gtk3_settings = File.join(node['user']['homedir'], '.config', 'gtk-3.0', 'settings.ini')

ppas.each do |ppa|
  apt_repository ppa do
    uri          "http://ppa.launchpad.net/gnome3-team/#{ppa}/ubuntu"
    distribution node['lsb']['codename']
    components   ['main']

    keyserver 'keyserver.ubuntu.com'
    key       '3B1510FD'
  end
end

execute 'apt-get update' do
  command 'apt-get update >/dev/null'
  returns 0
end

execute 'apt-get upgrade' do
  command 'apt-get upgrade -y >/dev/null'
  returns 0
end

execute 'apt-get dist-upgrade' do
  command 'apt-get dist-upgrade -y >/dev/null'
  returns 0
end

cookbook_file gtk3_settings do
  source 'gnome_gtk3_settings.ini'

  user  node['user']['login']
  group node['user']['group']
  mode  0640
end
