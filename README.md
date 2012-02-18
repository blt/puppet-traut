# Puppet control module for Traut

This module provides a resource that will manage the
[traut](https://github.com/blt/traut) system daemon and events. See linked
repository for full details of traut's functioning.

## Installation

Move into the root of your puppet configuration and:

    $ git submodule add git://github.com/blt/puppet-module-supervisor.git modules/supervisor
    $ git submodule add git://github.com/blt/puppet-traut.git modules/traut

If you're on a Debian system, optionally add:

    $ git submodule add git://github.com/blt/puppet-apt.git modules/apt

This last module will be used to set symlinks of convenience using Debian's
alternatives system.

## Quick Use

In a node definition (possibly your base):

```puppet
$traut_vhost = '/traut'
$traut_user  = 'traut'
$traut_pass  = 'averystrongpassword'
$traut_key   = '/etc/rabbitmq/ssl/client/key.pem'
$traut_chain = '/etc/rabbitmq/ssl/client/cert.pem'

class { 'traut':
  ensure => present,
  vhost => $traut_vhost,
  host => 'mq0',
  username => $traut_user,
  password => $traut_pass,
  exchange => 'traut',
  private_key => $traut_key,
  cert_chain => $traut_chain,
  require => File[$traut_key, $traut_chain],
  subscribe => File[$traut_key, $traut_chain],
}
include traut::hare
```

will:

  * install and configure the traut daemon, connecting with username, password
    and SSL client certificates to an AMQP daemon
  * install the optional [hare](https://github.com/blt/hare) and
  * coordinate the start of the daemon with supervisord.

If you don't possess a CA setup to issue and certify keys for RabbitMQ and
clients, try my [poor man's CA](https://github.com/blt/puppet-openssl).
