fn reduce [arr]{
  reduced = [ ] 
  for node $arr {
    if (not-eq $node '') {
      reduced = [ $@reduced $node ]
    }
  }
  put $reduced
}

fn remove_node [list match]{
  output = []
  for item $list {
    if (not-eq $item $match) {
      output = [$@output $item]
    }
  }
  put $output
}
