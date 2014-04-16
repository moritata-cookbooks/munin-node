#
# Cookbook Name:: munin-node
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

case node['platform_family']
when 'rhel', 'fedora'
  case node['platform_version'].to_i
  when 6
    package 'munin-node' do
      action :install
    end
  end
end

service "munin-node" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end


template "munin-node.conf.erb" do
  path "/etc/munin/munin-node.conf"
  source "munin-node.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload, 'service[munin-node]'
end
