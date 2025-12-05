#!/usr/bin/env ruby

require_relative '../util/enumerable'

def parse(stream)
    lines = stream.readlines.map(&:chomp)
    ranges, numbers = lines.split('')
    ranges = ranges.map{|line| line =~ /(.*)-(.*)/; [$1.to_i, $2.to_i]}
    numbers = numbers.map(&:to_i)
    [ranges, numbers]
end

def contains(range, number)
    range[0] <= number && number <= range[1]
end

ranges, numbers = parse(ARGF)
num_fresh_ingredients = numbers.count{|number| ranges.any?{|range| contains(range, number)}}
puts num_fresh_ingredients
