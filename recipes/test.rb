node.set['fqdn'] = 'test-zookeeper-001.optoro.com'
node.force_override['consul']['service_mode'] = 'bootstrap' # ~FC019
node.force_override['consul']['enable_syslog'] = false # ~FC019

package 'curl'
