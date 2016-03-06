# Bash profile

cookbook_file File.join(node['user']['homedir'], '.bash_profile') do
  owner node['user']['login']
  group node['user']['group']
  mode  0644

  source 'bash/profile'
end

directory File.join(node['user']['homedir'], '.bash_profile.d') do
  owner node['user']['login']
  group node['user']['group']
  mode  0755
end

configs = %w[debian editor prompt_command title]
configs.each do |config|
  cookbook_file File.join(node['user']['homedir'], '.bash_profile.d', config) do
    owner node['user']['login']
    group node['user']['group']
    mode  0644

    source "bash/profile_#{config}"
  end
end
