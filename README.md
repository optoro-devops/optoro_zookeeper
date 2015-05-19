# Description

Installs and configures Zookeeper using exhibitor

# Requirements

## Platform:

* Ubuntu (= 14.04)

## Cookbooks:

* apt
* exhibitor (>= 0.4.0)
* zookeeper (>= 2.4.1)
* aws (>= 2.5.3)
* optoro_metrics

# Attributes

* `node['exhibitor']['s3']['key']` -  Defaults to ``.
* `node['exhibitor']['s3']['secret']` -  Defaults to ``.
* `node['exhibitor']['cli']['s3config']` -  Defaults to `optoro-exhibitor:#{node.chef_environment}`.
* `node['exhibitor']['cli']['s3region']` -  Defaults to `us-east-1`.

# Recipes

* optoro_zookeeper::default - Installs Zookeeper the Optoro way

# License and Maintainer

Maintainer:: Optoro (<devops@optoro.com>)

License:: MIT
