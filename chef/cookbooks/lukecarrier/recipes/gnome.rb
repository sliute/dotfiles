ppas = %w[gnome3 gnome3-next gnome3-staging]

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
