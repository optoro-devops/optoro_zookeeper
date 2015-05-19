describe 'optoro_zookeeper::default' do
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

        it 'includes optoro_zookeeper::default' do
          expect(chef_run).to include_recipe('optoro_zookeeper::default')
        end
        it 'includes apt::default' do
          expect(chef_run).to include_recipe('apt::default')
        end
        it 'includes exhibitor::default' do
          expect(chef_run).to include_recipe('exhibitor::default')
        end
        it 'includes exhibitor::service' do
          expect(chef_run).to include_recipe('exhibitor::service')
        end
        it 'includes zookeeper::default' do
          expect(chef_run).to include_recipe('zookeeper::default')
        end
        it 'includes aws::default' do
          expect(chef_run).to include_recipe('aws::default')
        end
        it 'creates /var/lib/zookeeper' do
          expect(chef_run).to create_directory('/var/lib/zookeeper').with(user: 'zookeeper', group: 'zookeeper', mode: '0755')
        end
      end
    end
  end
end
