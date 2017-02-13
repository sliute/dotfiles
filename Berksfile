source "https://supermarket.chef.io"

# Main cookbook
cookbook 'lukecarrier', path: 'cookbooks/lukecarrier'

# Patched community cookbooks
cookbook 'atom', git: 'https://github.com/LukeCarrier/chef-atom.git',
                 branch: 'master'
cookbook 'nvm-ng', git: 'https://github.com/LukeCarrier/chef-nvm-ng.git',
                   branch: 'master'
cookbook 'skype-app', git: 'https://github.com/LukeCarrier/chef-skype-app.git',
                      branch: 'windows-remote-file'
cookbook 'virtualbox', git: 'https://github.com/LukeCarrier/chef-virtualbox.git',
                       branch: 'master'

# Community cookbooks
cookbook 'ark', '~> 2.2.1'
cookbook 'chocolatey', '~> 1.0.0'
cookbook 'chrome', '~> 1.1.1'
cookbook 'git', '~> 4.3.7'
cookbook 'steam', '~> 2.0.0'
cookbook 'vagrant', '~> 0.5.0'
cookbook 'winbox', '~> 0.9.101'
cookbook 'windows', '~> 1.39.2'

# Broken cookbooks
#cookbook 'gimp', '~> 1.1.0'
