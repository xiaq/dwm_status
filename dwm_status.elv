#!/bin/elvish

use str
use ./lib/dwm_date
use ./lib/dwm_battery
use ./lib/dwm_resources
use ./lib/dwm_network

dispatch_table = [
  $dwm_date:get~
  $dwm_battery:get~
  $dwm_resources:hdd~
  $dwm_resources:memory~
  $dwm_resources:cpu_temp~
  $dwm_network:traffic~
]

fn invoke_modules {
  for module $dispatch_table {
    $module
  }
}

while $true {
  xsetroot -name " "(invoke_modules | str:join ' ')" "
  sleep 1
}
