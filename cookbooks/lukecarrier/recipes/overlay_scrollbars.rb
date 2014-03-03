packages = %w[overlay-scrollbar overlay-scrollbar-gtk2 overlay-scrollbar-gtk3]

packages.each do |name|
  package name do
	  action :purge
	end
end
