arch_cost = { i386:   900,
              x86_64: 800, }

arch_cost.each do |arch, cost|
  yum_repository "rhughes-f20-gnome-3-12-#{arch}" do
    description "Copr repo for f20-gnome-3-12 owned by rhughes (#{arch})"
    baseurl     "http://copr-be.cloud.fedoraproject.org/results/rhughes/f20-gnome-3-12/fedora-$releasever-#{arch}"
    gpgcheck    false
    cost        cost.to_s

    action :create
  end
end

execute 'dnf upgrade -y'

