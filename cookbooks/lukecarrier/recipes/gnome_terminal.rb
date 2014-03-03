dconf_dump = File.join(run_context.cookbook_collection[cookbook_name].root_dir,
                       'files', 'default', 'gnome_terminal')
dconf_root = '/org/gnome/terminal'

script 'dconf reset -f && dconf load' do
  interpreter 'bash'
  cwd         node['user']['homedir']

  code <<-EOF
    sudo -u #{node['user']['login']} dconf reset -f #{dconf_root}/
    sudo -u #{node['user']['login']} dconf load     #{dconf_root}/ <#{dconf_dump}
  EOF

  returns 0
end
