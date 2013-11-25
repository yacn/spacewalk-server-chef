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

  %w{pgsql pgsql/data pgsql/backups}.each do |d|
    directory "/mnt/ephemeral/#{d}" do
      owner 'postgres'
      group 'postgres'
      mode  00700
      action :create
    end
  end

  cookbook_file '/mnt/ephemeral/pgsql/.bash_profile' do
    source 'postgres.bash_profile'
    owner 'postgres'
    group 'postgres'
    mode  00644
    action :create
  end

  directory '/var/lib/pgsql' do
    recursive true
    action :delete
    only_if { File::directory?('/var/lib/pgsql') }
  end

  link '/var/lib/pgsql' do
    to '/mnt/ephemeral/pgsql'
  end

  execute 'ensure-proper-selinux-context' do
    command '/usr/bin/chcon -Rt postgresql_db_t /mnt/ephemeral/pgsql'
    action :run
    # not sure if there is a proper idempotency guard that could be placed here
  end
end
