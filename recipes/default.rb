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

yum_key 'jpackage' do
  url 'http://www.jpackage.org/jpackage.asc'
  action :add
end

yum_repository 'jpackage-generic' do
  url 'http://mirrors.dotsrc.org/pub/jpackage/5.0/generic/free/'
  mirrorlist 'http://www.jpackage.org/mirrorlist.php?dist=generic&type=free&release=5.0'
  description 'JPackage Generic'
  key 'jpackage'
  enabled 1
  action :add
end

remote_file "#{Chef::Config[:file_cache_path]}/spacewalk-repo.rpm" do
  source node['spacewalk']['server']['repo_url']
  action :create
end

package 'spacewalk-repo' do
  source "#{Chef::Config[:file_cache_path]}/spacewalk-repo.rpm"
  action :install
end

%w{spacewalk-setup-postgresql spacewalk-postgresql}.each do |p|
  package p do
    action :install
  end
end

include_recipe "spacewalk-server::postgres-volume"

template "#{Chef::Config[:file_cache_path]}/spacewalk-answers.conf" do
  source 'spacewalk-answers.conf.erb'
  mode 0755
  action :create
end

execute 'spacewalk-setup' do
  command "spacewalk-setup --disconnected --answer-file=#{Chef::Config[:file_cache_path]}/spacewalk-answers.conf"
  action :run
  creates "/etc/rhn/rhn.conf"
end

link '/etc/init.d/spacewalk-service' do
  to '/usr/sbin/spacewalk-service'
  action :create
end

# RedHat init script doesn't support chkconfig. Imagine that...
service 'spacewalk-service' do
  supports :status => true, :reload => true, :restart => true
  action :start
end
