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
class puppetcron::repo (
  $ensure = hiera('puppetcron::ensure',
    $puppetcron::params::ensure),
  $minute = hiera('puppetcron::minute',
    $puppetcron::params::minute),
  $repo = hiera('puppetcron::repo',
    $puppetcron::params::repo),
  $revision = hiera('puppetcron::revision',
    $puppetcron::params::revision),
) inherits puppetcron::params {

  # Make sure the puppet repo is installed and set to
  # the proper branch.
  vcsrepo { '/etc/puppet':
    ensure   => latest,
    owner    => 'root',
    group    => 'root',
    provider => git,
    source   => $source,
    revision => $revision,
    }

}
