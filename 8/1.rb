#!/usr/bin/env ruby

require_relative 'common'

reps = ARGV.shift.to_i
input = parse(ARGF)
distances = compute_distances(input)
partition = Partition.new(input.size)
distances.sort.take(reps).each{|_, i, j| partition.add_connection(i, j)}
puts partition.sizes.sort.reverse.take(3).inject(&:*)
