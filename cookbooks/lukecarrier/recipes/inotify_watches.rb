cookbook_file File.join('etc', 'sysctl.d', '100-local-inotify-watches.conf') do
  source 'sysctl_inotify_watches.conf'

  owner 'root'
  group 'root'
  mode  0644
end

execute 'sudo systemctl restart systemd-sysctl'
