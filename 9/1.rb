#!/usr/bin/env ruby

def size(p, q)
    ((p[0] - q[0]).abs + 1) * ((p[1] - q[1]).abs + 1)
end

input = ARGF.readlines.map{|line| line.chomp.split(',').map(&:to_i)}
square_sizes = input.combination(2).map{|p, q| size(p, q)}
puts square_sizes.max
