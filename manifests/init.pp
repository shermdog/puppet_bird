# Class: puppet_bird
#
# This module manages puppet_bird
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class puppet_bird {
  bird_static_route{'4.2.2.0/24':
    ensure => present,
  }
}
