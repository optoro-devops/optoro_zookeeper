include_recipe 'optoro_consul::client'

optoro_consul_service 'zookeeper' do
  port 2181
  params node['optoro_consul']['service']
end
