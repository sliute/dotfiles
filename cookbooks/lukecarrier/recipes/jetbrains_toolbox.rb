if node['platform_family'] == 'debian'
  ark 'jetbrains-toolbox' do
    action   :put

    url      node['jetbrains_toolbox']['url']
    checksum node['jetbrains_toolbox']['checksum']

    path  node['user']['applicationdir']
    owner node['user']['login']
    group node['user']['group']
  end

  desktop_file = File.join(
      node['user']['homedir'], '.local', 'share', 'applications',
      'jetbrains-toolbox.desktop')
  cookbook_file desktop_file do
    owner node['user']['login']
    group node['user']['group']
    mode  0600

    source 'jetbrains_toolbox.desktop'
  end
end
