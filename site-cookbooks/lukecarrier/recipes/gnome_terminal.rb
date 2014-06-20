dconf_dump = File.join(run_context.cookbook_collection[cookbook_name].root_dir,
                       'files', 'default', 'gnome_terminal')
dconf_root = '/org/gnome/terminal'

bash 'dconf reset -f && dconf load' do
  cwd node['user']['homedir']

  code <<-EOF
    echo $USER

    su -c 'dconf reset -f #{dconf_root}/'                #{node['user']['login']}
    su -c 'dconf load     #{dconf_root}/ <#{dconf_dump}' #{node['user']['group']}
  EOF
end
