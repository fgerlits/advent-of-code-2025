#!/usr/bin/env ruby

class Partition
    def initialize(size)
        @leaders = size.times.to_a
    end

    def add_connection(a, b)
        raise unless a < b
        new, old = [@leaders[a], @leaders[b]].sort
        if new != old
            @leaders.map!{|leader| if leader == old then new else leader end}
        end
    end

    def sizes()
        @leaders.group_by(&:itself).map{|_, group| group.size}
    end
end

def parse(stream)
    stream.readlines.map{|line| line.chomp.split(',').map(&:to_i)}
end

def distance_squared(p, q)
    p.zip(q).map{|a, b| (a - b) ** 2}.sum
end


reps = ARGV.shift.to_i
input = parse(ARGF)
N = input.size
distances = (0...N).flat_map do |i|
    (i+1...N).map do |j|
        [distance_squared(input[i], input[j]), i, j]
    end
end
partition = Partition.new(N)
distances.sort.take(reps).each{|_, i, j| partition.add_connection(i, j)}
puts partition.sizes.sort.reverse.take(3).inject(&:*)
