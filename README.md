# DWM Status module

## This is a simple modular DWM status script written in elvish.

### Documentation

dwm_status.elv is the bootstrap script and is responsible for loading all modules within the lib/ directory.
The user should edit this file and include / exclude any modules they wish to be displayed.

### Requirements

This script requires some binaries to be installed on the base system

`
dwm
elvish
df
acpi
ip
date
sensors
free
`

### Instructions

The script can be executed via

`elvish [..path..to..]/dwm_status.elv &`

However to ensure you do not have to manually run the script each time dwm is launched it is recommended that the above command is added to the .xinitrc file, and will therefore be spawned on `startx`.

### Thanks

Thanks to @xiaq for feedback on the module loader / network module.
