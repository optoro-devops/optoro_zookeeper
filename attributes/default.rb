override['zookeeper']['version'] = '3.4.6'
override['zookeeper']['checksum'] = '01b3938547cd620dc4c93efe07c0360411f4a66962a70500b163b59014046994'
default!['exhibitor']['cli']['configtype'] = 's3'
default['exhibitor']['cli']['s3config'] = "optoro-exhibitor:#{node.chef_environment}"
default['exhibitor']['cli']['s3region'] = 'us-east-1'
node.default!['zookeeper']['group'] = 'zookeeper'
override['zookeeper']['mirror'] = 'https://archive.apache.org/dist/zookeeper'

# Consul
default['optoro_consul']['register_consul_service'] = false

override['zookeeper']['config_dir'] = "#{node['zookeeper']['install_dir']}/zookeeper-#{node['zookeeper']['version']}/conf"
override['zookeeper']['env_vars']['ZOOCFGDIR'] = "#{node['zookeeper']['install_dir']}/zookeeper-#{node['zookeeper']['version']}/conf"
