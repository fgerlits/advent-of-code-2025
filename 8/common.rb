class Partition
    def initialize(size)
        @leaders = size.times.to_a
    end

    def add_connection(a, b)
        raise unless a < b
        new, old = [@leaders[a], @leaders[b]].sort
        if new != old
            @leaders.map!{|leader| if leader == old then new else leader end}
        end
    end

    def sizes
        @leaders.group_by(&:itself).map{|_, group| group.size}
    end

    def single_blob?
        @leaders.all?{|x| x == 0}
    end
end

def parse(stream)
    stream.readlines.map{|line| line.chomp.split(',').map(&:to_i)}
end

def distance_squared(p, q)
    a, b, c = p[0] - q[0], p[1] - q[1], p[2] - q[2]
    a * a + b * b + c * c
end

def compute_distances(points)
    n = points.size
    (0...n).flat_map do |i|
        (i+1...n).map do |j|
            [distance_squared(points[i], points[j]), i, j]
        end
    end
end
