class traut::service {
  supervisor::service { 'traut':
    ensure    => running,
    enable    => true,
    numprocs  => 1,
    command   => "traut -C /etc/traut/traut.conf",
    startsecs => 3,
    require   => File['/etc/traut/traut.conf'],
    subscribe => File['/etc/traut/traut.conf'],
    alias     => Service['traut'],
  }
}
