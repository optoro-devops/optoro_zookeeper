name 'optoro_zookeeper'
maintainer 'Optoro'
maintainer 'devops@optoro.com'
license 'MIT'
description 'Installs and configures Zookeeper using exhibitor'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.1'

depends 'apt'
depends 'exhibitor'
depends 'zookeeper'
depends 'aws'
