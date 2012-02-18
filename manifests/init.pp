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
)
{
  include traut::package, traut::service

  $traut_conf = '/etc/traut'
  $includedir = '/etc/traut/events.d'
  $logdir     = '/var/log/traut'

  file {
    $traut_conf:
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

}
