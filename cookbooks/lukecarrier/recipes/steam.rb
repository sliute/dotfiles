include_recipe 'lukecarrier::rpmfusion_repo'

remote_file '/etc/yum.repos.d/negativo17-steam.repo' do
  source 'http://negativo17.org/repos/fedora-steam.repo'

  owner 'root'
  group 'root'
  mode   0644
end

package 'steam'
