#
# Cookbook Name:: optoro_zookeeper
# Recipe:: default
#
# Copyright (C) 2014
#
# All rights reserved - Do Not Redistribute
#
s3_keys = Chef::EncryptedDataBagItem.load('aws', 'aws_keys')
node.default['exhibitor']['s3']['access-key-id'] = s3_keys['exhibitor_access_key_id']
node.default['exhibitor']['s3']['access-secret-key'] = s3_keys['exhibitor_secret_access_key']

zookeepers = []
if node['fqdn']
  # Build out list of zookeeper servers before installing exhibitor
  zookeepers = ["S:#{node['fqdn'].scan(/\d+/).first.to_i}:#{node['ipaddress']}"]
end

unless Chef::Config.solo
  search(:node, "recipes:optoro_zookeeper\\:\\:default AND chef_environment:#{node.chef_environment}").each do |n|
    if n['fqdn']
      zookeepers << "S:#{n['fqdn'].scan(/\d+/).first.to_i}:#{n['ipaddress']}"
    end
  end
  # Dedup our host name out of the array
  zookeepers = zookeepers.uniq
end

node.default['exhibitor']['config']['servers_spec'] = zookeepers.join(',')

include_recipe 'apt'
include_recipe 'exhibitor'
include_recipe 'exhibitor::service'
include_recipe 'zookeeper'

# We hard code using exhibitor to bring up ZK nodes
node.default['zookeeper']['service_style'] = 'exhibitor'

directory node['zookeeper']['config']['dataDir'] do
  mode '0755'
  owner node['zookeeper']['user']
  group node['zookeeper']['group']
  action :create
end

include_recipe 'optoro_zookeeper::zookeeper_exporter'
