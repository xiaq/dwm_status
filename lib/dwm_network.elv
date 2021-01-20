use str
use math
use ./helpers

direction_symbols = [RX: TX:]
network = [&]
net = [&]
throughput = []
history = ""

fn load_network {
  interfaces = [(ip addr | awk '/state UP/ {print $2}')]
  for node $interfaces {
    node = (str:replace ":" "" $node)
    if (not-eq $node "lo") {
      output_raw = [(ip -s link show $node)]
      counter = 0
      for output $output_raw {
        for direction $direction_symbols {
          if (str:contains $output $direction) {
            titles = (helpers:reduce [(splits ' ' $output_raw[$counter])])
            values = (helpers:reduce [(splits ' ' $output_raw[(+ $counter 1)])])

            titles = (helpers:remove_node $titles $direction)
            counter2 = 0
            
            for title $titles {
              net[$title] = $values[$counter2]
              counter2 = (+ $counter2 1)
            }

            network[(str:replace ":" "" $direction)] = $net
          }
        }
        counter = (+ $counter 1)
      }
    }
  }

  traffic = []
  if (> (count $network) 0) {
    keys $network | each [x]{ 
      info = $network[$x]
      traffic = [ $@traffic $info[bytes] ]
    }
    put $traffic
  }
}

fn traffic {
  throughput = [ $@throughput (load_network) ]
  if (> (count $throughput) 1) {
    run1 = $throughput[0]
    run2 = $throughput[1]

    download = (/ (- $run2[0] $run1[0]) 1024)
    upload = (/ (- $run2[1] $run1[1]) 1024)

    history = "[ "(printf "%.2f" $download)" "(printf "%.2f" $upload)" ]"
    throughput = []
  }
  put $history
}
