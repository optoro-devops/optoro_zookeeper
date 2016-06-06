#
# Cookbook Name:: optoro_zookeeper
# Recipe:: default
#
# Copyright (C) 2014
#
# All rights reserved - Do Not Redistribute
#

chef_gem 'chef-rewind' do
  compile_time true if respond_to?(:compile_time)
end
require 'chef/rewind'

zookeepers = []
if node['fqdn']
  # Build out list of zookeeper servers before installing exhibitor
  zookeepers = ["S:#{node['fqdn'].scan(/\d+/).first.to_i}:#{node['ipaddress']}"]
end

unless Chef::Config.solo
  search(:node, "recipes:optoro_zookeeper AND chef_environment:#{node.chef_environment}").each do |n|
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
include_recipe 'aws'
include_recipe 'optoro_zookeeper::consul' if node['optoro_consul']['register_consul_service']

s3_creds = query_role_credentials
node.default!['exhibitor']['s3']['access_key_id'] = s3_creds['AccessKeyId']
node.default!['exhibitor']['s3']['access_secret_key'] = s3_creds['SecretAccessKey']
node.default!['exhibitor']['cli']['configtype'] = 's3'

# We hard code using exhibitor to bring up ZK nodes
node.default['zookeeper']['service_style'] = 'exhibitor'

zookeeper '3.4.6' do
  user 'zookeeper'
  mirror 'http://apache.mirrors.hoobly.com/zookeeper/'
  checksum '01b3938547cd620dc4c93efe07c0360411f4a66962a70500b163b59014046994'
  action :install
end

directory node['zookeeper']['config']['dataDir'] do
  mode '0755'
  owner node['zookeeper']['user']
  group node['zookeeper']['group']
  action :create
end

# Get rid of the recipe provided exhibitor configs.
unwind 'file[/opt/exhibitor/exhibitor.s3.properties]'

file ::File.join(node['exhibitor']['install_dir'], 'exhibitor.s3.properties') do
  owner node['exhibitor']['user']
  owner node['exhibitor']['group']
  mode 0400
  content(render_s3_credentials(node['exhibitor']['s3']))
  action :create
end
