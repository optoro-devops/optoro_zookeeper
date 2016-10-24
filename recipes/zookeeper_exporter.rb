include_recipe 'optoro_consul::client'

tar_extract 'https://s3.amazonaws.com/latest-container-assets/zookeeper_exporter.tar.gz' do
  user 'root'
  group 'root'
  target_dir '/opt'
end

file '/opt/zookeeper_exporter' do
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/init/zookeeper_exporter.conf' do
  action :create
  source 'zookeeper_exporter.init.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

service 'zookeeper_exporter' do
  action [:enable, :start]
  supports :restart => true
end

consul_definition 'zookeeper-metrics' do
  type 'service'
  parameters(
    port: 9114,
    tags: [node['fqdn']],
    enableTagOverride: false,
    check: {
      interval: '10s',
      timeout: '5s',
      http: 'http://localhost:9114/metrics'
    }
  )
  notifies :reload, 'consul_service[consul]', :delayed
end
