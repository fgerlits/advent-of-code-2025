#!/usr/bin/env ruby

CELL_MAPPING = {'S' => 1, '.' => 0, '^' => :split}

def parse(stream)
    stream.readlines.map do |line|
        line.chomp.each_char.map{|c| CELL_MAPPING[c]}
    end
end

grid = parse(ARGF)
xsize, ysize = grid.size, grid[0].size

(1...xsize).each do |x|
    (0...ysize).each do |y|
        current = grid[x - 1][y]
        if current != :split && current > 0
            if grid[x][y] != :split
                grid[x][y] += current
            else
                grid[x][y - 1] += current
                grid[x][y + 1] += current
            end
        end
    end
end

puts grid.last.sum
