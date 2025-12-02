#!/usr/bin/env ruby

def parse(line)
    line =~ /(\d+)-(\d+)/
    [$1, $2]
end

def fixup(pairs)
    pairs.flat_map do |from, to|
        if from.size == to.size
            [[from, to]]
        elsif from.size + 1 == to.size
            [[from, '9' * from.size], ['1' + '0' * from.size, to]]
        else
            raise "unexpected input #{from}-#{to}"
        end
    end
end

def divisors(num)
    1.upto(num / 2).select{|d| num % d == 0}
end

def part_from(num_str, d)
    first = num_str.slice(0, d).to_i
    if num_str.to_i <= times(first, num_str.size / d)
        first
    else
        first + 1
    end
end

def part_to(num_str, d)
    first = num_str.slice(0, d).to_i
    if times(first, num_str.size / d) <= num_str.to_i
        first
    else
        first - 1
    end
end

def times(num, x)
    (num.to_s * x).to_i
end

input = ARGF.read.split(',').map{|pair| parse(pair)}
input = fixup(input)
invalid_ids = input.flat_map do |from, to|
    divisors(from.size).flat_map do |d|
        from_part, to_part = part_from(from, d), part_to(to, d)
        (from_part..to_part).map{|num| times(num, from.size / d)}
    end.uniq
end
puts invalid_ids.sum
