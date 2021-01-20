#!/bin/elvish

use ./lib/dwm_date
use ./lib/dwm_battery
use ./lib/dwm_resources
use ./lib/dwm_network
modules = [ ]

dispatch_table = [
  $dwm_date:get~
  $dwm_battery:get~
  $dwm_resources:hdd~
  $dwm_resources:memory~
  $dwm_resources:cpu_temp~
  $dwm_network:traffic~
]

fn populate {
  modules = [ ]

  for module $dispatch_table {
    modules = [ $@modules ($module) ]
  }
}

while $true {
  populate
  xsetroot -name " "(joins ' ' $modules)" "
  sleep 1
}
