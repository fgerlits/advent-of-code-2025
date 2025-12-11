#!/usr/bin/env ruby

def parse(stream)
    stream.readlines.map do |line|
        from, *to_list = line.split
        [from[...-1], to_list]
    end.to_h
end

def _num_paths(from, to)
    if from == to
        1
    else
        $graph[from].map{|child| num_paths(child, to)}.sum
    end
end

$memo = {}
def num_paths(from, to)
    $memo[[from, to]] ||= _num_paths(from, to)
end

$graph = parse(ARGF)
$graph["out"] = []

a1 = num_paths("svr", "dac")
a2 = num_paths("dac", "fft")
a3 = num_paths("fft", "out")

b1 = num_paths("svr", "fft")
b2 = num_paths("fft", "dac")
b3 = num_paths("dac", "out")

puts a1 * a2 * a3 + b1 * b2 * b3
