#!/usr/bin/env ruby

instructions = ARGF.map{|line| line =~ /^(.)(\d+)/; [$1, $2.to_i]}
$dial = 50
dial_positions = instructions.map do |dir, num|
  if dir == 'L'
    $dial = ($dial - num) % 100
  else
    $dial = ($dial + num) % 100
  end
  $dial
end
puts dial_positions.count(0)
