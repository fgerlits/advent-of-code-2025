#!/usr/bin/env ruby

require_relative '../util/enumerable'

def parse_target(str)
    str[1...-1].each_char.with_index.flat_map{|ch, ix| {'.' => [], '#' => [ix]}[ch]}
end

def parse_buttons(instructions)
    instructions.map{|instr| instr[1...-1].split(',').map(&:to_i)}
end

def parse(stream)
    stream.readlines.map do |line|
        target, *buttons, joltage = line.split
        [parse_target(target), parse_buttons(buttons)]
    end
end

def result_of(buttons)
    buttons.flatten.freqs.select{|val, freq| freq.odd?}.map{|val, _| val}.sort
end

def fewest_button_presses(machine)
    target, buttons = machine
    1.upto(buttons.size) do |n|
        buttons.combination(n) do |selected_buttons|
            if result_of(selected_buttons) == target
                return n
            end
        end
    end
    raise "no solution found for #{target}, #{buttons}"
end

input = parse(ARGF)
puts input.map{|machine| fewest_button_presses(machine)}.sum
