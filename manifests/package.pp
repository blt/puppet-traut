class traut::package {
  package { 'traut':
    provider => gem,
    ensure => present,
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
