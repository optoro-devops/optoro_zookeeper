shared_context 'optoro_zookeeper' do
  before do
    Chef::Recipe.any_instance.stub(:query_role).and_return('kitchen_role')
    Chef::Recipe.any_instance.stub(:query_role_credentials).and_return('{ "Code" : "Success", "LastUpdated" : "2015-03-09T14:48:17Z", "Type" : "AWS-HMAC", "AccessKeyId" : "ACCESSKEY", "SecretAccessKey" : "SECRETKEY", "Token" : "TOKEN", "Expiration" : "2015-03-09T21:14:00Z" }')

    allow(Chef::EncryptedDataBagItem).to receive(:load).with('aws', 'aws_keys').and_return('id' => 'aws_keys', 'exhibitor_access_key_id' => 'ACCESS', 'exhibitor_secret_access_key' => 'SECRET')
  end
end
