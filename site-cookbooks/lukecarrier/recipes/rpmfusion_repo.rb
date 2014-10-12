release = node['platform_version']

%w{ free nonfree }.each do |variant|
  package_name = "rpmfusion-#{variant}-release-#{release}"
  rpm_path     = ::File.join(Chef::Config[:file_cache_path], "rpmfusion-#{variant}.rpm")

  remote_file rpm_path do
    source "http://download1.rpmfusion.org/#{variant}/fedora/#{package_name}.noarch.rpm"
  end

  execute "dnf install #{package_name}" do
    command "dnf install -y #{rpm_path}"
    not_if "rpm -qa | grep '#{package_name}'"
  end
end
