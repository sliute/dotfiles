# Home directory structure

directory node['user']['applicationdir'] do
  owner node['user']['login']
  group node['user']['group']
  mode  0700
end

directory node['user']['bindir'] do
  owner node['user']['login']
  group node['user']['group']
  mode  0700
end
