# Example --config S3 values
default['exhibitor']['cli']['configtype'] = 's3'
default['exhibitor']['cli']['s3config'] = "optoro-exhibitor:#{node.chef_environment}"
default['exhibitor']['cli']['s3region'] = 'us-east-1'

if node['ec2']
  s3_creds = query_role_credentials # ~FC044
else
  s3_creds = Chef::EncryptedDataBagItem.load('credentials', 's3')
end

default['exhibitor']['s3']['access_key_id'] = s3_creds['AccessKeyId']
default['exhibitor']['s3']['access_secret_key'] = s3_creds['SecretAccessKey']
