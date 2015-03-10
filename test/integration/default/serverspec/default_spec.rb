require 'spec_helper'
require 'net/http'
require 'uri'

describe 'optoro_zookeeper::default' do
  describe file('/var/lib/zookeeper') do
    it { should be_directory }
    it { should be_mode '755' }
    it { should be_owned_by 'zookeeper' }
    it { should be_grouped_into 'zookeeper' }
  end
  describe file('/opt/exhibitor/exhibitor.s3.properties') do
    it { should be_file }
    it { should be_mode '400' }
    it { should be_owned_by 'zookeeper' }
    it { should be_grouped_into 'root' }
  end
  describe service('runsvdir') do
    it { should be_enabled }
  end
  describe service('exhibitor') do
    it { should be_running }
  end
  describe process('java -Dzookeeper.log.dir=. -Dzookeeper.root.logger=INFO,CONSOLE') do
    it { should be_running }
  end
  describe process('java -Dlog4j.configuration=file:///opt/exhibitor/log4j.properties') do
    it { should be_running }
  end
  describe port(2181) do
    it { should be_listening }
  end
  describe port(8080) do
    it { should be_listening }
  end
end
