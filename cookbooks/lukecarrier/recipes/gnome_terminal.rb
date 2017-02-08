# Gnome Terminal

#puts run_context.node.to_yaml
#puts run_context.cookbook_collection[cookbook_name].to_yaml

cookbook   = run_context.cookbook_collection[cookbook_name]
dconf_dump = cookbook.preferred_filename_on_disk_location(run_context.node, :files, 'gnome_terminal')
dconf_root = '/org/gnome/terminal'

bash 'dconf reset -f && dconf load' do
  cwd node['user']['homedir']

  code <<-EOF
    su -c 'dconf reset -f #{dconf_root}/' #{node['user']['login']}
    su -c 'cat #{dconf_dump} | dconf load #{dconf_root}/' #{node['user']['group']}
  EOF
end
