# Example --config S3 values
default['exhibitor']['s3']['key'] = 'KEY'
default['exhibitor']['s3']['secret'] = 'SECRET'
default['exhibitor']['cli']['s3config'] = "optoro-exhibitor:#{node.chef_environment}"
default['exhibitor']['cli']['s3region'] = 'us-east-1'
force_default['zookeeper']['group'] = 'zookeeper'
override['zookeeper']['mirror'] = 'https://archive.apache.org/dist/zookeeper'

# Consul
default['optoro_consul']['register_consul_service'] = false
default['consul']['version'] = '0.6.3'
default['consul']['base_url'] = "https://releases.hashicorp.com/consul/#{node['consul']['version']}/consul_%{version}.zip"
default['consul']['checksums'] = {
  '0.6.3_linux_amd64' => 'b0532c61fec4a4f6d130c893fd8954ec007a6ad93effbe283a39224ed237e250',
  '0.6.3_web_ui' => '93bbb300cacfe8de90fb3bd5ede7d37ae6ce014898edc520b9c96a676b2bbb72'
}
