def least_common_multiple(num_1, num_2)
    (num_1..num_1 * num_2).each { |n| return n if n % num_1 == 0 && n % num_2 == 0 }
end


def most_frequent_bigram(str)
    hash = Hash.new(0)
    (0...str.length - 1).each { |i| hash[str[i..i+1]] += 1 }
    sorted = hash.sort_by { |k, v| v }
    sorted.last[0]
end


class Hash
    # Write a method, Hash#inverse, that returns a new hash where the key-value pairs are swapped
    def inverse
        hash = {}
        self.each { |k, v| hash[v] = k }
        hash
    end
end



class Array
    # Write a method, Array#pair_sum_count, that takes in a target number returns the number of pairs of elements that sum to the given target
    def pair_sum_count(num)
        count = 0
        (0...self.length).each do |i|
            (i+1...self.length).each { |j| count += 1 if self[i] + self[j] == num }
        end
        count
    end

    def bubble_sort(&prc)
        prc ||= Proc.new { |a, b| a <=> b } #return 1 if a > b => 2nd ele goes first :)

        sorted = false
        while !sorted
            sorted = true
            (0...self.length - 1).each do |i|
                if prc[self[i], self[i+1]] == 1
                    self[i], self[i+1] = self[i+1], self[i]
                    sorted = false
                end
            end
        end
        self
    end
end
