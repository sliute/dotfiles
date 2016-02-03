script 'install carrier repo' do
  interpreter 'bash'
  cwd         node['user']['homedir']

  code <<-EOF
    dist=$(rpm --eval %{dist})
    curl -o /etc/yum.repos.d/carrier.repo \
            "http://rpm.carrier.im/repo/carrier${dist}.repo"
    yum check-update || true
  EOF
end
