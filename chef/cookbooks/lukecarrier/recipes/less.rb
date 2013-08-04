package 'less'
package 'source-highlight'

cookbook_file File.join(node['user']['homedir'], '.bash_profile.d', 'less') do
  source 'bash_profile_less'

  owner node['user']['login']
  group node['user']['group']
  mode  0644
end
