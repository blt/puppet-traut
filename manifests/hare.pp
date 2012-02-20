class traut::hare {
  package { 'hare':
    provider => gem,
    ensure => present,
  }

  if defined('apt::alternatives') {
    apt::alternatives { 'hare':
      ensure => present,
      link => '/usr/bin/hare',
      path => '/var/lib/gems/1.9.1/bin/hare',
      require => Package['hare'],
    }
  }
}
