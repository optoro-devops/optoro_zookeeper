name 'optoro_zookeeper'
maintainer 'Optoro'
maintainer_email 'devops@optoro.com'
license 'MIT'
description 'Installs and configures Zookeeper using exhibitor'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url 'https://github.com/optoro-devops/optoro_zookeeper'
version '0.0.14'

supports 'ubuntu', '= 14.04'

provides 'optoro_zookeeper::default'
recipe 'optoro_zookeeper::default', 'Installs Zookeeper the Optoro way'

depends 'apt'
depends 'exhibitor', '>= 0.4.0'
depends 'zookeeper', '~> 6.0'
depends 'optoro_consul'
depends 'tar'
