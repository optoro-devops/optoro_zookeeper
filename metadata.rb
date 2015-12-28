name 'optoro_zookeeper'
maintainer 'Optoro'
maintainer_email 'devops@optoro.com'
license 'MIT'
description 'Installs and configures Zookeeper using exhibitor'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.11'

supports 'ubuntu', '= 14.04'

provides 'optoro_zookeeper::default'
recipe 'optoro_zookeeper::default', 'Installs Zookeeper the Optoro way'

depends 'apt'
depends 'exhibitor', '>= 0.4.0'
depends 'zookeeper', '>= 2.4.1'
depends 'aws', '~> 2.5.3'
