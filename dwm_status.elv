#!/bin/elvish

# use ./lib/dwm_date
modules = [ ]

fn dwm_date {
  modules = [ $@modules "[ "(date "+DATE: %d/%m/%y TIME: %H:%M:%S")" ]" ]
}

fn dwm_battery {
  modules = [ $@modules "[ "(acpi -b | cut -d ',' -f 2 | cut -d ' ' -f 2)" ]" ]
}

fn populate {
  modules = [ ]
  dwm_date
  dwm_battery
}

while $true {
  populate
  xsetroot -name (joins ' ' $modules)
  sleep 1
}
