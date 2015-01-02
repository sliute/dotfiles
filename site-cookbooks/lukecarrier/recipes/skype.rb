rpm_path = ::File.join(Chef::Config[:file_cache_path], 'skype-skype.rpm')

remote_file rpm_path do
  source 'http://download.skype.com/linux/skype-4.3.0.37-fedora.i586.rpm'
end

rpm_package "skype" do
  source rpm_path
end

