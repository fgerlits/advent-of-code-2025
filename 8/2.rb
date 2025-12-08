#!/usr/bin/env ruby

require_relative 'common'

input = parse(ARGF)
distances = compute_distances(input).sort_by{|distance, _, _| distance}
partition = Partition.new(input.size)
last_to_connect = distances.each do |_, i, j|
    partition.add_connection(i, j)
    if partition.single_blob?
        break [i, j]
    end
end
puts last_to_connect.map{|i| input[i][0]}.inject(&:*)
