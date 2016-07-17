# == Class: puppetcron
#
# Full description of class puppetcron here.
#
# === Examples
#
#  class { 'puppetcron':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name flannon@nyu.edu
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class puppetcron (
  $ensure = hiera('puppetcron::ensure',
    $puppetcron::params::ensure),
  $minute = hiera('puppetcron::minute',
    $puppetcron::params::minute),
  $revision = hiera('puppetcron::revision',
    $puppetcron::params::revision),
  $revision = hiera('puppetcron::source',
    $puppetcron::params::source),
) inherits puppetcron::params {

  # Install puppetcron script to manage puppet runs
  file { '/usr/local/sbin/puppetcron.sh':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0744',
    source => 'puppet:///modules/puppetcron/puppetcron.sh'),
    notify => Cron['puppet-cron'],
    }

  # Run puppet once every half hour
  cron { 'puppet-cron' :
    ensure  => $ensure,
    command => '/usr/local/sbin/puppetcron.sh >> /var/log/puppet/puppetcron',
    user    => 'root',
    minute  => "$minute-59/30",
    require => File['/usr/local/sbin/puppetcron.sh'],
  }

}
