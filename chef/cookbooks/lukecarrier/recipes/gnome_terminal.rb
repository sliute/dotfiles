# Assumes the presence of a Gnome Terminal version backed by dconf and not
# gconf.

# Base16 Ocean theme
# Name  Hex      RGB
# BG    #2b303b  rgb(43 , 48 , 59 )
# FG    #c0c5ce  rgb(192, 197, 206)
# 00    #2b303b  rgb(43 , 48 , 59 )
# 01    #343d46  rgb(52 , 61 , 70 )
# 02    #4f5b66  rgb(79 , 91 , 102)
# 03    #65737e  rgb(101, 115, 126)
# 04    #a7adba  rgb(167, 173, 186)
# 05    #c0c5ce  rgb(192, 197, 206)
# 06    #dfe1e8  rgb(223, 225, 232)
# 07    #eff1f5  rgb(239, 241, 245)
# 08    #bf616a  rgb(191, 97 , 106)
# 09    #d08770  rgb(208, 135, 112)
# 0A    #ebcb8b  rgb(235, 203, 139)
# 0B    #a3be8c  rgb(163, 190, 140)
# 0C    #96b5b4  rgb(150, 181, 180)
# 0D    #8fa1b3  rgb(143, 161, 179)
# 0E    #b48ead  rgb(180, 142, 173)
# 0F    #ab7967  rgb(171, 121, 103)

dconf_dump = File.join(run_context.cookbook_collection[cookbook_name].root_dir,
                       'files', 'default', 'gnome_terminal_profile_base16_ocean')
dconf_key  = '/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/'

script 'dconf reset -f && dconf load' do
  interpreter 'bash'
  cwd         node['user']['homedir']
  user        node['user']['login']
  group       node['user']['group']

  code <<-EOF
    dconf reset -f #{dconf_key}
    dconf load     #{dconf_key} <#{dconf_dump}
  EOF

  returns 0
end
