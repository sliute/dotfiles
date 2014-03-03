script 'install carrier repo' do
  interpreter 'bash'
  cwd         node['user']['homedir']
  user        node['user']['login']
  group       node['user']['group']

  code <<-EOF
  	dist=$(rpm --eval %{dist})
  	wget -qO /etc/yum.repos.d/carrier.repo \
  	         "http://rpms.carrier.im/repo/carrier${dist}.repo"
  	yum check-update
  EOF
end
