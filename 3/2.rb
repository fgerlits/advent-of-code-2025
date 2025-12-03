#!/usr/bin/env ruby

def parse(line)
    line.chomp.each_char.map(&:to_i)
end

def max_joltage(bank)
    max = 0
    maxes = bank.reverse.map{|n| max = [n, max].max}.reverse
    multiplier = 1
    2.upto(12) do |num_batteries|
        max = 0
        multiplier *= 10
        maxes = (bank.size - num_batteries).downto(0).map do |i|
            max = [multiplier * bank[i] + maxes[i + 1], max].max
        end.reverse
    end
    maxes[0]
end

input = ARGF.readlines.map{|line| parse(line)}
max_joltage = input.map{|bank| max_joltage(bank)}
puts max_joltage.sum
