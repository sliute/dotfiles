rpm_path = ::File.join(Chef::Config[:file_cache_path], 'flash_plugin-adobe_release.rpm')

remote_file rpm_path do
  source 'http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm'
end

rpm_package 'adobe-release' do
  source rpm_path
end

package 'flash-plugin'
