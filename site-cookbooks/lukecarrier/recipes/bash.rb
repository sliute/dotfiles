configs = %w[editor path prompt_command title]

cookbook_file File.join(node['user']['homedir'], '.bash_profile') do
  owner node['user']['login']
  group node['user']['group']
  mode  0644

  source 'bash_profile'
end

directories = %w[.bash_profile.d .local/bin]
directories.map! {|current_directory| File.join(node['user']['homedir'], current_directory)}
directories << node['user']['applicationdir']

directories.each do |current_directory|
  directory current_directory do
    owner node['user']['login']
    group node['user']['group']
    mode  0755
  end
end

file File.join(node['user']['homedir'], '.bash_profile.d', '_') do
  action :touch

  owner node['user']['login']
  group node['user']['group']
  mode  0644
end

configs.each do |config|
  cookbook_file File.join(node['user']['homedir'], '.bash_profile.d', config) do
    owner node['user']['login']
    group node['user']['group']
    mode  0644

    source "bash_profile_#{config}"
  end
end
