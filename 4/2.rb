#!/usr/bin/env ruby

class Grid
    def initialize(stream)
        @grid = stream.readlines.map{|line| line.each_char.to_a}
        @xsize = @grid.size
        @ysize = @grid[0].size
    end

    def all_num_neighbors()
        (0...@xsize).flat_map do |x|
            (0...@ysize).map do |y|
                [[x, y], at(x, y), num_neighbors(x, y)]
            end
        end
    end

    def num_neighbors(x, y)
        NEIGHBORS.map{|dx, dy| at(x + dx, y + dy)}.count('@')
    end

    NEIGHBORS = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]

    def at(x, y)
        if x >= 0 && x < @xsize && y >= 0 && y < @ysize
            @grid[x][y]
        end
    end

    def remove(positions)
        positions.each do |x, y|
            @grid[x][y] = '.'
        end
    end
end

grid = Grid.new(ARGF)
removed = 0
loop do
    to_remove = grid.all_num_neighbors()
            .filter{|_, cell, num_nb| cell == '@' && num_nb < 4}
            .map{|pos, _, _| pos}
    if to_remove.empty?
        break
    end
    grid.remove(to_remove)
    removed += to_remove.size
end
puts removed
