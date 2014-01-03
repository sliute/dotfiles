apt_repository 'lastfm' do
  uri          'http://apt.last.fm/debian'
  distribution 'testing'
  components   ['main']

  keyserver 'pgp.mit.edu'
  key       'D49EEAA0'
end

package 'lastfm-scrobbler'

execute 'fix launcher path' do
  command 'sed -ie \'s!^Exec=.*!Exec=/usr/bin/lastfm-scrobbler!\' /usr/share/applications/lastfm-client.desktop'
  returns 0
end

