#!/usr/bin/env ruby

require 'benchmark'
require_relative 'common'

Benchmark.bm(10) do |bm|
  input, distances, partition, last_to_connect = nil
  bm.report("parsing:            ") do
    input = parse(ARGF)
  end
  bm.report("compute distances:  ") do
    distances = compute_distances(input)
  end
  bm.report("sorting distances:  ") do
    distances.sort_by!{|dist, i, j| dist}
  end
  bm.report("adding connections: ") do
    partition = Partition.new(input.size)
    last_to_connect = distances.each do |_, i, j|
        partition.add_connection(i, j)
        if partition.single_blob?
            break [i, j]
        end
    end
  end
  puts last_to_connect.map{|i| input[i][0]}.inject(&:*)
end
