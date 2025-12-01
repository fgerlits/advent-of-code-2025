#!/usr/bin/env ruby

instructions = ARGF.map{|line| line =~ /^(.)(\d+)/; [$1, $2.to_i]}
$dial = 50
$clicks_at_zero = 0
dial_positions = instructions.map do |dir, num|
  dial_before = $dial
  if dir == 'L'
    at_zero, $dial = divmod($dial - num, 100)
  else
    at_zero, $dial = divmod($dial + num, 100)
  end
  $clicks_at_zero += at_zero.abs
  if (dir == 'R' && $dial == 0) || (dir == 'L' && dial_before == 0)
    $clicks_at_zero -= 1
  end
  $dial
end
puts dial_positions.count(0) + $clicks_at_zero
