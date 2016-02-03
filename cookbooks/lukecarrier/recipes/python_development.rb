build_libs = %w[bzip2 sqlite]

git File.join(node['user']['homedir'], '.pyenv') do
  repository 'https://github.com/yyuu/pyenv.git'
  revision 'master'

  user  node['user']['login']
  group node['user']['group']
end

cookbook_file File.join(node['user']['homedir'], '.bash_profile.d', 'pyenv') do
  source 'bash_profile_pyenv'

  owner node['user']['login']
  group node['user']['group']
  mode  0644
end

build_libs.each { |lib| package "#{lib}-devel" }
