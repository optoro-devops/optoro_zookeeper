describe 'optoro_zookeeper::consul' do
  Resources::PLATFORMS.each do |platform, value|
    value['versions'].each do |version|
      context "On #{platform} #{version}" do
        include_context 'optoro_zookeeper'

        let(:chef_run) do
          ChefSpec::ServerRunner.new(platform: platform, version: version, log_level: :error) do |node, server|
            env = Chef::Environment.new
            env.name 'test-kitchen'
            allow(node).to receive(:chef_environment).and_return(env.name)
            allow(Chef::Environment).to receive(:load).and_return(env)
            node.set['lsb']['codename'] = value['codename']
            node.automatic['fdqn'] = 'test-zookeeper-001.optoro.com'
            server.create_environment('test-kitchen')
            server.create_node('test-zookeeper-002.optoro.com',
                               run_list: ['recipe[optoro_zookeeper::default]'],
                               normal: {
                                 'fqdn' => 'test-zookeeper-002.optoro.com',
                                 'ipaddress' => '192.168.1.100'
                               },
                               'chef_environment' => 'test-kitchen'
                              )
          end.converge(described_recipe)
        end
      end
    end
  end
end
