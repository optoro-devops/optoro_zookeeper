name 'optoro_zookeeper'
maintainer 'Optoro'
maintainer 'devops@optoro.com'
license 'MIT'
description 'Installs and configures Zookeeper using exhibitor'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.3'

depends 'apt', '>= 2.6.1'
depends 'exhibitor', '>= 0.4.0'
depends 'zookeeper', '>= 2.4.1'
depends 'aws', '>= 2.5.3'
