# Monkey-Patch Ruby's existing Array class to add your own custom methods

class Array
    #PART I

    def span
        self.max - self.min if self.length > 0
    end

    def average
        (1.0 * self.sum) / self.length if self.length > 0
    end

    def median
        if self.length.odd?
            return self.sort[self.length/2]
        elsif self.length > 0
            return (self.sort[self.length/2] + self.sort[self.length/2 - 1]) / 2.0
        end
    end

    def counts
        hash = Hash.new(0)
        self.each { |ele| hash[ele] += 1 }
        hash
    end

    #PART II

    def my_count(val)
        counts[val]
    end

    def my_index(val)
        self.each_with_index { |ele, i| return i if ele == val  }
        nil
    end

    def my_uniq
        counts.keys
    end

    def my_transpose
        (0...self.length).each do |i|
            (i...self.length).each { |j| self[i][j], self[j][i] = self[j][i], self[i][j] }
        end
        self
    end
end
