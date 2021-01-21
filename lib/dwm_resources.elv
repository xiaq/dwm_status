use str
use ./helpers

fn memory {
  memory_raw=[(str:split ' ' (free -h | grep Mem))]
  memory_raw = (helpers:reduce $memory_raw)
  put "[ RAM: "$memory_raw[2]"/"$memory_raw[1] "]"
}

fn hdd {
  hdd_raw=[(str:split ' ' (df -h / | grep /))]
  hdd_raw=(helpers:reduce $hdd_raw)
  put "[ HDD: / "$hdd_raw[3]"/"$hdd_raw[2] ": "$hdd_raw[4]"]"
}

fn cpu_temp {
  cpu_raw=[(str:split ' ' (sensors | grep Package))]
  put "[ CPU TEMP: "$cpu_raw[4]" ]"
}
