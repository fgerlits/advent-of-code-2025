#!/usr/bin/env ruby

def parse(line)
    line =~ /(\d+)-(\d+)/
    [$1, $2]
end

def fixup(pairs)
    pairs.map do |from, to|
        if from.size == to.size
            [[from, to]]
        elsif from.size + 1 == to.size
            [[from, '9' * from.size], ['1' + '0' * from.size, to]]
        else
            raise "unexpected input #{from}-#{to}"
        end
    end.flatten(1)
end

def divisors(num)
    1.upto(num / 2).select{|d| num % d == 0}
end

def parts(num_str, d)
    num_str.each_char.each_slice(d).map(&:join).map(&:to_i)
end

def map_from(num_str, d)
    first, *rest = parts(num_str, d)
    if num_str.to_i <= times(first, num_str.size / d)
        first
    else
        first + 1
    end
end

def map_to(num_str, d)
    first, *rest = parts(num_str, d)
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
sum_invalid = input.map do |from, to|
    divisors(from.size).map do |d|
        from_part, to_part = map_from(from, d), map_to(to, d)
        (from_part..to_part).map{|num| times(num, from.size / d)}
    end.flatten.uniq
end.flatten.sum
puts sum_invalid
