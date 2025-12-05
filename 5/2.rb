#!/usr/bin/env ruby

require_relative '../util/enumerable'

class Interval
    include Comparable
    attr_reader :left, :right

    def initialize(left, right)
        raise "bad interval" unless left <= right
        @left, @right = left, right
    end

    def <=>(other) = [@left, @right] <=> [other.left, other.right]

    def size = @right - @left + 1
end

def parse_interval(line)
    line =~ /(.*)-(.*)/
    Interval.new($1.to_i, $2.to_i)
end

def parse(stream)
    stream.readlines.map(&:chomp).split('')[0].map{|line| parse_interval(line)}
end

ranges = parse(ARGF).sort
disjoint_ranges = []
current = nil
ranges.each do |range|
    if current.nil?
        current = range
    elsif range.left <= current.right
        current = Interval.new(current.left, [current.right, range.right].max)
    else
        disjoint_ranges << current
        current = range
    end
end
raise "no intervals?" if current.nil?
disjoint_ranges << current
puts disjoint_ranges.map(&:size).sum
