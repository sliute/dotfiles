source "https://supermarket.chef.io"

# Main cookbook
cookbook 'lukecarrier', path: 'cookbooks/lukecarrier'

# Patched community cookbooks
cookbook 'atom', git: 'https://github.com/LukeCarrier/atom-cookbook.git',
                 branch: 'master'
cookbook 'virtualbox', git: 'https://github.com/LukeCarrier/virtualbox-cookbook.git',
                       branch: 'master'

cookbook 'chrome', '~> 1.1.1'
cookbook 'git', '~> 4.3.7'
cookbook 'skype-app', '~> 0.2.0'
cookbook 'steam', '~> 2.0.0'
cookbook 'winbox', '~> 0.9.101'
cookbook 'windows', '~> 1.39.2'

# Broken cookbooks
#cookbook 'gimp', '~> 1.1.0'
