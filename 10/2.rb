#!/usr/bin/env ruby

require_relative '../util/enumerable'

def parse_buttons(instructions)
    instructions.map{|instr| instr[1...-1].split(',').map(&:to_i)}
end

def parse_joltage(str)
    str[1...-1].split(',').map(&:to_i)
end

def parse(stream)
    stream.readlines.map do |line|
        _, *buttons, target_joltage = line.split
        [parse_joltage(target_joltage), parse_buttons(buttons)]
    end
end

def _partitions(num, size)
    if num == 0
        return [[0] * size]
    end
    partitions(num - 1, size).flat_map do |partition|
        (0...size).map{|pos| pc = partition.clone; pc[pos] += 1; pc}
    end.uniq
end

$memo = {}
def partitions(num, size)
    $memo[[num, size]] ||= _partitions(num, size)
end

def result_of(size, buttons, weights)
    joltage = [0] * size
    buttons.zip(weights).each do |button, weight|
        button.each{|pos| joltage[pos] += weight}
    end
    joltage
end

def fewest_button_presses(machine)
    target, buttons = machine
    1.upto(MAX) do |n|
        print "#{n}, "
        partitions(n, buttons.size).each do |num_presses|
            if result_of(target.size, buttons, num_presses) == target
                return n
            end
        end
    end
    raise "no solution found for #{target}, #{buttons}"
end

MAX = 100
input = parse(ARGF)
puts input.map{|machine| puts; p machine; fewest_button_presses(machine)}.sum
