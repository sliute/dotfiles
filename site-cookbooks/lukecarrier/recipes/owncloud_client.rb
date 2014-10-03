remote_file '/etc/yum.repos.d/isv:ownCloud:desktop.repo' do
  source 'http://download.opensuse.org/repositories/isv:ownCloud:desktop/Fedora_20/isv:ownCloud:desktop.repo'
end

package 'mirall'
