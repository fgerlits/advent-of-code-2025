#!/usr/bin/env ruby

def parse(line)
    line.chomp.each_char.map(&:to_i)
end

def max_joltage(bank)
    max = 0
    maxes = bank.reverse.map{|n| max = [n, max].max}.reverse
    max_joltage = 0
    0.upto(bank.size - 2) do |i|
        max_joltage = [10 * bank[i] + maxes[i + 1], max_joltage].max
    end
    max_joltage
end

input = ARGF.readlines.map{|line| parse(line)}
max_joltage = input.map{|bank| max_joltage(bank)}
puts max_joltage.sum
