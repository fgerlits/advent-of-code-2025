#!/usr/bin/env ruby

require_relative '../util/enumerable'

def parse(stream)
    *numbers, ops = stream.readlines.map(&:chomp)
    numbers = numbers.map(&:each_char).map(&:to_a).transpose
            .map(&:join).map(&:strip).split('')
            .map{|strings| strings.map(&:to_i)}
    [numbers, ops.split]
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
