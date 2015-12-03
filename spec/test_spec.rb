describe 'optoro_zookeeper::test' do
  Resources::PLATFORMS.each do |platform, value|
    value['versions'].each do |version|
      context "On #{platform} #{version}" do
        include_context 'optoro_zookeeper'

        let(:chef_run) do
          ChefSpec::ServerRunner.new(platform: platform, version: version, log_level: :error) do |_node|
          end.converge(described_recipe)
        end
      end
    end
  end
end
