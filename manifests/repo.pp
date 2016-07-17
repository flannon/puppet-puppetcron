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
  $revision = hiera('puppetcron::revision',
    $puppetcron::params::revision),
  $repo = hiera('puppetcron::source',
    $puppetcron::params::source),
) inherits puppetcron::params {

  # This makes sure that the the puppet repo is installed
  # and up to date with the latest commit.
  vcsrepo { '/etc/puppet':
    ensure   => latest,
    owner    => 'root',
    group    => 'root',
    provider => git,
    revision => $revision,
    source   => $source,
    }

}
