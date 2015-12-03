# Example --config S3 values
node.default!['exhibitor']['cli']['configtype'] = 's3'
default['exhibitor']['s3']['key'] = ''
default['exhibitor']['s3']['secret'] = ''
default['exhibitor']['cli']['s3config'] = "optoro-exhibitor:#{node.chef_environment}"
default['exhibitor']['cli']['s3region'] = 'us-east-1'
node.default!['zookeeper']['group'] = 'zookeeper'
override['zookeeper']['mirror'] = 'https://archive.apache.org/dist/zookeeper'
