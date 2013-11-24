#
# Cookbook Name:: spacewalk-server
# Recipe:: postgres-volume
#
# Copyright (C) 2013 Opscode, Inc.
# 
# All rights reserved - Do Not Redistribute
#

if node['ec2']
  include_recipe 'ephemeral_lvm'

  directory '/var/lib/pgsql' do
    action :delete
  end

  directory '/mnt/ephemeral/pgsql' do
    owner 'postgres'
    group 'postgres'
    mode  00750
    action :create
  end

  link '/var/lib/pgsql' do
    to '/mnt/ephemeral/pgsql'
  end
end
