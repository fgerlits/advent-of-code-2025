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
                [at(x, y), num_neighbors(x, y)]
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
end

input = Grid.new(ARGF)
puts input.all_num_neighbors().count{|cell, num_nb| cell == '@' && num_nb < 4}
