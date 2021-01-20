fn get {
  raw_output = [(acpi -b)]
  for node $raw_output {
    direction = (echo $node | cut -d ',' -f 1 | cut -d ' ' -f 3)
    battery = (echo $node | cut -d ',' -f 2 | cut -d ' ' -f 2)
    direction_symbol = ''
    if (not-eq $direction "Unknown") {
      direction_symbol = '-'
      if (eq $direction Charging) {
        direction_symbol = '+'
      }
      put "[ "$battery$direction_symbol" ]"
    }
  }
}
