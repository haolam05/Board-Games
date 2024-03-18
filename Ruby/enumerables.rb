class Array
    # My Each
    # Extend the Array class to include a method named my_each that takes a block, calls the block on every element of the array, 
    # and returns the original array. Do not use Enumerable's each method. I want to be able to write
    def my_each(&blk)
        self.length.times { |i| blk[self[i]] }
        self
    end

    # My Select
    # Now extend the Array class to include my_select that takes a block and returns a new array containing only elements 
    # that satisfy the block. Use your my_each method!
    def my_select(&blk)
        new_arr = []
        self.my_each { |el| new_arr << el if blk[el] }  #self.length.times { |i| new_arr << self[i] if blk[self[i]] }
        new_arr
    end

    # My Reject
    # Write my_reject to take a block and return a new array excluding elements that satisfy the block.
    def my_reject(&blk)
        new_arr = []
        self.my_each { |el| new_arr << el if !blk[el] }
        new_arr
    end

    # My Any
    # Write my_any? to return true if any elements of the array satisfy the block
    def my_any?(&blk)
        self.my_each { |el| return true if blk[el] }
        false
    end

    # My All
    # Write my_all? to return true only if all elements satisfy the block
    def my_all?(&blk)
        self.my_each { |el| return false if !blk[el] }
        true
    end

    # My Flatten
    # my_flatten should return all elements of the array into a new, one-dimensional array. Hint: use recursion!
    def my_flatten
        flattened = []

        self.my_each do |el|
            flattened += el.my_flatten if el.is_a?(Array)
            flattened << el if !el.is_a?(Array)
        end

        flattened
    end

    # My Zip
    # Write my_zip to take any number of arguments. It should return a new array containing self.length elements. 
    # Each element of the new array should be an array with a length of the input arguments + 1 and contain the 
    # merged elements at that index. If the size of any argument is less than self, nil is returned for that location.
    def my_zip(*arrs)
        zipped = []

        self.length.times do |i| 
            zipped << [self[i]] 
            arrs.my_each { |arr| zipped[i] << arr[i] }
        end

        zipped
    end

    # My Rotate
    # Write a method my_rotate that returns a new array containing all the elements of the original array in a rotated order. 
    # By default, the array should rotate by one element. If a negative value is given, the array is rotated in the 
    # opposite direction.
    def my_rotate(n=1)
        self.drop(n % self.length) + self.take(n % self.length)
    end

    # def my_rotate(n=1)
        # new_arr = []
        # self.my_each { |el| new_arr << el }

        # n.abs.times do 
        #     new_arr.push(new_arr.shift) if n > 0
        #     new_arr.unshift(new_arr.pop) if n < 0
        # end
        
        # new_arr 
    # end

    # My Join
    # my_join returns a single string containing all the elements of the array, separated by the given string separator. 
    # If no separator is given, an empty string is used.
    def my_join(separator = '')
        str = ''
        (self.length - 1).times { |i| str += self[i] + separator }  # self.join(separator)
        str + self.last
    end

    # My Reverse
    # Write a method that returns a new array containing all the elements of the original array in reverse order.
    def my_reverse
        new_arr = []
        self.my_each { |el| new_arr.unshift(el) }
        new_arr
    end
end

# My Each
# calls my_each twice on the array, printing all the numbers twice.
return_value = [1, 2, 3].my_each do |num|
  puts num
end.my_each do |num|
  puts num
end
# =>    #  1
        #  2
        #  3
        #  1
        #  2
        #  3

p return_value  # => [1, 2, 3]
p '---------------------------------------------------'

# My Select
a = [1, 2, 3]
p a.my_select { |num| num > 1 } # => [2, 3]
p a.my_select { |num| num == 4 } # => []
p '---------------------------------------------------'

# My Reject
a = [1, 2, 3]
p a.my_reject { |num| num > 1 } # => [1]
p a.my_reject { |num| num == 4 } # => [1, 2, 3]
p '---------------------------------------------------'

# My Any
a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false
p '---------------------------------------------------'

# My All
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true
p '---------------------------------------------------'

# My Flatten
p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]
p '---------------------------------------------------'

# My Zip
a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]
p '---------------------------------------------------'

# My Rotate
a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]
p '---------------------------------------------------'

# My Join
a = [ "a", "b", "c", "d" ]
p a.my_join         # => "abcd"
p a.my_join("$")    # => "a$b$c$d"
p '---------------------------------------------------'

# My Reverse
p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]
p '---------------------------------------------------'



