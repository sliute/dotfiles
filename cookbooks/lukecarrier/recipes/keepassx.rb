# KeePassX password manager

case node['platform_family']
when 'debian'
  package 'keepassx'
when 'windows'
  require 'win32ole'
  all_users_programs = WIN32OLE.new('WScript.Shell').SpecialFolders('AllUsersPrograms')

  version = node['keepassx']['version']
  url = "https://www.keepassx.org/releases/#{version}/KeePassX-#{version}.zip"

  executable = File.join(node['keepassx']['install_dir'], "KeePassX-#{version}", 'KeePassX.exe')

  windows_zipfile node['keepassx']['install_dir'] do
    source url
    action :unzip

    not_if { File.exist?(node['keepassx']['install_dir']) }
  end

  windows_shortcut File.join(all_users_programs, 'KeePassX.lnk') do
    target executable
    description 'KeePassX password manager'
    iconlocation "#{executable}, 0"
  end
end
