# Assumes the presence of a Gnome Terminal version backed by dconf and not
# gconf.

dconf_dump = File.join(run_context.cookbook_collection[cookbook_name].root_dir,
                       'files', 'default', 'gnome_terminal')
dconf_root = '/org/gnome/terminal'

script 'dconf reset -f && dconf load' do
  interpreter 'bash'
  cwd         node['user']['homedir']
  user        node['user']['login']
  group       node['user']['group']

  code <<-EOF
    dconf reset -f #{dconf_root}/
    dconf load     #{dconf_root}/ <#{dconf_dump}
  EOF

  returns 0
end
