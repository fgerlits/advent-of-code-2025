#!/usr/bin/env ruby

def parse(line)
    line =~ /(\d+)-(\d+)/
    [$1, $2]
end

def halves(num)
    size = num.size / 2
    [num.slice(0, size).to_i, num.slice(size, size).to_i]
end

def map_from(num)
    left, right = halves(num)
    if right > left
        left + 1
    else
        left
    end
end

def map_to(num)
    left, right = halves(num)
    if right >= left
        left
    else
        left - 1
    end
end

def double(num)
    "#{num}#{num}".to_i
end

def sum_closed_interval(from, to)
    if from > to
        0
    else
        (double(from) + double(to)) * (to - from + 1) / 2
    end
end

input = ARGF.readlines.map{|line| parse(line)}
sum_invalid = input.map do |from, to|
    sum_closed_interval(map_from(from), map_to(to))
end.sum
puts sum_invalid
