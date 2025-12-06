#!/usr/bin/env ruby

def parse(stream)
    *numbers, ops = stream.readlines.map(&:chomp)
    [numbers.map{|line| line.split.map(&:to_i)}.transpose, ops.split]
end

def calculate(numbers, op)
    case op
    when '+'
        numbers.inject(&:+)
    when '*'
        numbers.inject(&:*)
    end
end

numbers, ops = parse(ARGF)
puts numbers.zip(ops).map{|numbers, op| calculate(numbers, op)}.sum
