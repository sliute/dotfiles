rpm_path = ::File.join(Chef::Config[:file_cache_path], 'skype-skype.rpm')

remote_file rpm_path do
  source 'http://download.skype.com/linux/skype-4.3.0.37-fedora.i586.rpm'
end

# Skype really ought to sort their shit out, seriously!?
dependencies = [
    "alsa-lib",
    "alsa-plugins-pulseaudio",
    "fontconfig",
    "freetype",
    "glib2",
    "libSM",
    "libXScrnSaver",
    "libXi",
    "libXrandr",
    "libXrender",
    "libXv",
    "libstdc++",
    "pulseaudio-libs",
    "qt",
    "qt-x11",
    "zlib",
    "qtwebkit",
]
dependencies.each do |dependency|
  package "#{dependency}.i686"
end

rpm_package "skype" do
  source rpm_path
end

