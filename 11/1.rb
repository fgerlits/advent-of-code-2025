#!/usr/bin/env ruby

def parse(stream)
    stream.readlines.map do |line|
        from, *to_list = line.split
        [from[...-1], to_list]
    end.to_h
end

def num_paths_from(node, graph)
    if node == "out"
        1
    else
        graph[node].map{|child| num_paths_from(child, graph)}.sum
    end
end

input = parse(ARGF)
puts num_paths_from("you", input)
