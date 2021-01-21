use str

last = $nil
history = ""

fn load_network {
  rx = 0
  tx = 0
  ip -j -s link | from-json | all (one) | each [iface]{
    if (eq $iface[ifname] lo) {
      continue
    }
    rx = (+ $rx $iface[stats64][rx][bytes])
    tx = (+ $tx $iface[stats64][tx][bytes])
  }
  put [$rx $tx]
}

fn traffic {
  current = (load_network)
  if $last {
    rx_delta = (/ (- $current[0] $last[0]) 1024)
    tx_delta = (/ (- $current[1] $last[1]) 1024)
    history = "[ RX: "(printf "%.2f" $rx_delta)" TX: "(printf "%.2f" $tx_delta)" ]"
  }
  last = $current
  put $history
}
