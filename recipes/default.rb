#
# Cookbook Name:: spacewalk-server
# Recipe:: default
#
# Copyright (C) 2013 Yet Another Clever Name
# 
# All rights reserved - Do Not Redistribute
#

# Add required YUM repos
include_recipe 'yum::epel'

yum_key 'JPackage' do
  url 'http://www.jpackage.org/jpackage.asc'
  action :create
end

yum_repository 'JPackage generic' do
  url 'http://mirrors.dotsrc.org/pub/jpackage/5.0/generic/free/'
  mirrorlist 'http://www.jpackage.org/mirrorlist.php?dist=generic&type=free&release=5.0'
  key 'JPackage'
  enabled 1
  action :add
end

package 'postgresql-contrib'
package 'spacewalk-setup-postgresql'

template '/tmp/spacewalk-answers.conf' do
  source 'spacewalk-answers.conf.erb'
  mode 0755
  action :create_if_missing
end

package 'spacewalk-postgresql'

execute 'spacewalk-setup' do
  command 'spacewalk-setup --disconnected --answer-file="/tmp/spacewalk-answers.conf"'
  action :run
end

service 'spacewalk-service' do
  supports :status => true, :reload => true, :restart => true
  action [ :enable, :start ]
end
