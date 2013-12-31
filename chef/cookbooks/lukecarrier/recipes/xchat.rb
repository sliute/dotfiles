package 'xchat'

config   = File.join(node['user']['homedir'], '.xchat2')
servlist = File.join(config, 'servlist_.conf')

unless File.directory?(config)
  script 'xchat --minimize=0' do
    interpreter 'bash'
    cwd         node['user']['homedir']
    user        node['user']['login']
    group       node['user']['group']

    code <<-EOF
      xchat --minimize=0 &
      sleep 2
      pkill xchat
    EOF

    returns 0
  end
end

if node['xchat']['servlist'].length > 0
  remote_file servlist do
  	source node['xchat']['servlist']

    user  node['user']['login']
    group node['user']['group']
    mode  0640
  end
end
