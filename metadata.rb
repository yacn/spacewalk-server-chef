name             'spacewalk-server'
maintainer       'Yet Another Clever Name'
maintainer_email 'admin@yacn.pw'
license          'MIT'
description      'Installs/Configures a Spacewalk Server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

%w[fedora redhat centos].each do |os|
  supports os
end

depends 'iptables'
depends 'yum', '> 3.0.0'
depends 'yum-epel'
depends 'yum-fedora'
depends 'ephemeral_lvm'
