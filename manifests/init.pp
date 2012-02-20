class traut(
  $ensure=present,
  $host='localhost',
  $port='5671',
  $debugging=false,
  $vhost,
  $username,
  $password,
  $exchange,
  $private_key,
  $cert_chain,
  $version=present,
)
{
  include traut::service

  $traut_conf = '/etc/traut'
  $includedir = '/etc/traut/events.d'
  $logdir     = '/var/log/traut'

  file {
    $traut_conf:
      require => Package['traut'],
      ensure => directory;
    $includedir:
      require => File[$traut_conf],
      ensure => directory;
    $logdir:
      ensure => directory;
    "${traut_conf}/traut.conf":
      require => File[$traut_conf],
      content => template('traut/traut.conf.erb'),
      ensure => $ensure ? { present => file, default => $ensure, };
  }

  package { 'traut':
    provider => gem,
    ensure => $version,
  }

  if defined('apt::alternatives') {
    apt::alternatives { 'traut':
      ensure => present,
      link => '/usr/bin/traut',
      path => '/var/lib/gems/1.9.1/bin/traut',
      require => Package['traut'],
    }
  }
}
