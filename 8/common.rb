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
    (p[0] - q[0])**2 + (p[1] - q[1])**2 + (p[2] - q[2])**2
end

def compute_distances(points)
    result = []
    n = points.size
    (0...n).each do |i|
        p = points[i]
        (i+1...n).each do |j|
            q = points[j]
            result << [distance_squared(p, q), i, j]
        end
    end
    result
end
