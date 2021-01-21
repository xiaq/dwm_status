use str
use math
use ./helpers

throughput = []
history = ""

# ip -js link | from-json | pprint (one)

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
  throughput = [ $@throughput (load_network) ]
  if (> (count $throughput) 1) {
    run1 = $throughput[0]
    run2 = $throughput[1]

    download = (/ (- $run2[0] $run1[0]) 1024)
    upload = (/ (- $run2[1] $run1[1]) 1024)

    history = "[ RX: "(printf "%.2f" $download)" TX: "(printf "%.2f" $upload)" ]"
    throughput = []
  }
  put $history
}
