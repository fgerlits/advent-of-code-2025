#!/usr/bin/env ruby

def parse(stream)
    stream.readlines.map{|line| line.chomp.each_char.to_a}
end

grid = parse(ARGF)
xsize, ysize = grid.size, grid[0].size

split_counter = 0
(1...xsize).each do |x|
    (0...ysize).each do |y|
        if grid[x - 1][y] == '|' || grid[x - 1][y] == 'S'
            if grid[x][y] == '^'
                grid[x][y - 1] = '|'
                grid[x][y + 1] = '|'
                split_counter += 1
            else
                grid[x][y] = '|'
            end
        end
    end
end

puts split_counter
