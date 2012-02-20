# Sets a traut event for a given route and command
#
# Parameters
#  [*ensure*] -- Sets availability of the event (present|absent)
#   *route*   -- The AMQP route key to respond to
#   *command* -- The system command to execute on event reception.
#  [*user*]   -- Set the user to invoke the command as.
#  [*group*]  -- Set the group to invoke the command as.
#
define traut::resource::event($ensure=present, $route, $command, $user='', $group='') {
  file { "${traut::includedir}/${title}.yml":
    ensure => $ensure ? { present => file, default => absent, },
    content => template('traut/event.yml.erb'),
    require => Class['traut'],
    notify => Supervisor::Service['traut'],
  }
}
