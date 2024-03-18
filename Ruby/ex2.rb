#Warmup
# Write a recursive method, range, that takes a start and an end and returns an array of all numbers in that range, exclusive. 
# For example, range(1, 5) should return [1, 2, 3, 4]. If end < start, you can return an empty array.
# Write both a recursive and iterative version of sum of an array.
def recursive_range(start_num, end_num)

end

p recursive_range(1, 5)   #=> [1, 2, 3, 4]
p recursive_range(5, 1)   #=> []
puts '------'

def iterative_range(start_num, end_num)

end

p iterative_range(1, 5)   #=> [1, 2, 3, 4]
p iterative_range(5, 1)   #=> []
puts '--------------------------------------------------------------------------'


# Exponentiation
# Write two versions of exponent that use two different recursions:
# this is math, not Ruby methods.

# recursion 1
#   - exp(b, 0) = 1
#   - exp(b, n) = b * exp(b, n - 1)
def exp1(base, power)

end

p exp1(1, 0)    #=> 1
p exp1(1, 1)    #=> 1
p exp1(1, 2)    #=> 1
p exp1(2, 0)    #=> 1
p exp1(2, 1)    #=> 2
p exp1(2, 2)    #=> 4
p exp1(5, 3)    #=> 125
p exp1(8, 2)    #=> 64
puts '------'

# recursion 2
#   - exp(b, 0) = 1
#   - exp(b, 1) = b
#   - exp(b, n) = exp(b, n / 2) ** 2             [for even n]
#   - exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]
def exp2(base, power)

end

p exp2(1, 0)    #=> 1
p exp2(1, 1)    #=> 1
p exp2(1, 2)    #=> 1
p exp2(2, 0)    #=> 1
p exp2(2, 1)    #=> 2
p exp2(2, 2)    #=> 4
p exp2(5, 3)    #=> 125
p exp2(8, 2)    #=> 64
puts '--------------------------------------------------------------------------'


# Deep dup
# The #dup method doesn't make a deep copy:
# Using recursion and the #is_a? method, write an Array#deep_dup method 
# that will perform a "deep" duplication of the interior arrays.
# Note: For simplicity's sake, we are only going to ensure the deep duplication of arrays. 
# Don't worry about deep-duping (or regular-duping) other types of mutable objects 
# (like strings, hashes, instances of custom classes, etc.), 
# since this would require that we implement a deep dup method for each of those classes, as well.
# It's okay to iterate over array elements using the normal each for this one
class Array
    def deep_dup

    end 
end

a = [1, [2], [3, [4]]]  #=> a = [1, [2], [3, [4]]]
b = a.deep_dup          #=> b = [1, [2], [3, [4]]]
b[2][1] << 5
p a                     #=> a = [1, [2], [3, [4]]]
p b                     #=> b = [1, [2], [3, [4, 5]]]
puts '--------------------------------------------------------------------------'


#Fibonacci
# Write a recursive and an iterative Fibonacci method. 
# The method should take in an integer n and return the first n Fibonacci numbers in an array.
# You shouldn't have to pass any arrays between methods; 
# you should be able to do this just passing a single argument for the number of Fibonacci numbers requested.
# fibonacci sequence:  0, 1, 1, 2, 3, 5, 8, 13, 21, 34, ...

def recursive_fibonacci(n)

end

p recursive_fibonacci(1)    #[0]
p recursive_fibonacci(2)    #[0, 1]
p recursive_fibonacci(3)    #[0, 1, 1]
p recursive_fibonacci(4)    #[0, 1, 1, 2]
p recursive_fibonacci(5)    #[0, 1, 1, 2, 3]
p recursive_fibonacci(6)    #[0, 1, 1, 2, 3, 5]
p recursive_fibonacci(7)    #[0, 1, 1, 2, 3, 5, 8]
p recursive_fibonacci(8)    #[0, 1, 1, 2, 3, 5, 8, 13]
p recursive_fibonacci(9)    #[0, 1, 1, 2, 3, 5, 8, 13, 21]
p recursive_fibonacci(10)   #[0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
puts '------'

def iterative_fibonacci(n)

end

p iterative_fibonacci(1)    #[0]
p iterative_fibonacci(2)    #[0, 1]
p iterative_fibonacci(3)    #[0, 1, 1]
p iterative_fibonacci(4)    #[0, 1, 1, 2]
p iterative_fibonacci(5)    #[0, 1, 1, 2, 3]
p iterative_fibonacci(6)    #[0, 1, 1, 2, 3, 5]
p iterative_fibonacci(7)    #[0, 1, 1, 2, 3, 5, 8]
p iterative_fibonacci(8)    #[0, 1, 1, 2, 3, 5, 8, 13]
p iterative_fibonacci(9)    #[0, 1, 1, 2, 3, 5, 8, 13, 21]
p iterative_fibonacci(10)   #[0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
puts '--------------------------------------------------------------------------'

#Binary Search
# Write a recursive binary search: bsearch(array, target). 
# Note that binary search only works on sorted arrays. 
# Make sure to return the location of the found object (or nil if not found!). 
# Hint: you will probably want to use subarrays.

def bsearch(arr, target)

end

p bsearch([1, 2, 3], 1)             # => 0
p bsearch([2, 3, 4, 5], 3)          # => 1
p bsearch([2, 4, 6, 8, 10], 6)      # => 2
p bsearch([1, 3, 4, 5, 9], 5)       # => 3
p bsearch([1, 2, 3, 4, 5, 6], 6)    # => 5
p bsearch([1, 2, 3, 4, 5, 6], 0)    # => nil
p bsearch([1, 2, 3, 4, 5, 7], 6)    # => nil
puts '--------------------------------------------------------------------------'


#Merge Sort
# Implement a method merge_sort that sorts an Array:
# The base cases are for arrays of length zero or one. 
# Do not use a length-two array as a base case. This is unnecessary.
# You'll want to write a merge helper method to merge the sorted halves.
# To get a visual idea of how merge sort works, watch this gif and check out this diagram.

class Array
    def merge_sort

    end

    def merge(left, right)

    end
end
                
p [].merge_sort             #=> []
p [9].merge_sort            #=> [9]
p [4,1,3,5,2].merge_sort    #=> [1, 2, 3, 4, 5]
puts '--------------------------------------------------------------------------'


# Array Subsets
# Write a method subsets that will return all subsets of an array.
# You can implement this as an Array method if you prefer.
# Hint: For subsets([1, 2, 3]), there are two kinds of subsets:
# Those that do not contain 3 (all of these are subsets of [1, 2]).
# For every subset that does not contain 3, there is also a corresponding subset that is the same, except it also does contain 3.
def subsets(arr)

end

p subsets([]) # => [[]]
p subsets([1]) # => [[], [1]]
p subsets([1, 2]) # => [[], [1], [2], [1, 2]]           
p subsets([1, 2, 3]) # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
puts '--------------------------------------------------------------------------'


#Permutations
# Write a recursive method permutations(array) that calculates all the permutations of the given array. 
# For an array of length n there are n! different permutations. 
# So for an array with three elements we will have 3 * 2 * 1 = 6 different permutations.
# You can use Ruby's built in Array#permutation method to get a better understanding of what you will be building.

def permutations(arr)

end

p [].permutation.to_a          # => [[]]
p permutations([])
                                
p [1].permutation.to_a          # => [[1]]
p permutations([1])

p [1,2].permutation.to_a        # => [[1, 2], [2, 1]]
p permutations([1, 2])
puts '------'

p [1,2,3].permutation.to_a      # => [  [1, 2, 3], [1, 3, 2],
                                #       [2, 1, 3], [2, 3, 1],
                                #       [3, 1, 2], [3, 2, 1]  ]
p permutations([1, 2, 3])    
puts '--------------------------------------------------------------------------'


#Make Change
# First, write a 'greedy' version called greedy_make_change:
# Take as many of the biggest coin as possible and add them to your result.
# Add to the result by recursively calling your method on the remaining amount, 
# leaving out the biggest coin, until the remainder is zero.

def make_change(amt, coins = [25, 10, 5, 1])

end        

p make_change(77)       #=> [25, 25, 25, 1, 1]
p make_change(39)       #=> [25, 10, 1, 1, 1, 1]
p make_change(24)       #=> [10, 10, 1, 1, 1, 1]
p make_change(14)       #=> [10, 1, 1, 1, 1]
p make_change(15)       #=> [10, 5]
p make_change(8)        #=> [5, 1, 1, 1]
p make_change(0)        #=> []
puts '------'

def make_change_2(amt, coins = [10, 7 ,1])     

end   

p make_change_2(77)     #=> [10, 10, 10, 10, 10, 10, 10, 7]
p make_change_2(39)     #=> [10, 10, 10, 7, 1, 1]
p make_change_2(24)     #=> [10, 7, 7]
p make_change_2(14)     #=> [7, 7]
p make_change_2(15)     #=> [7, 7, 1]
p make_change_2(8)      #=> [7, 1]
p make_change_2(0)      #=> []
puts '--------------------------------------------------------------------------'






















# #Warmup
# # Write a recursive method, range, that takes a start and an end and returns an array of all numbers in that range, exclusive. 
# # For example, range(1, 5) should return [1, 2, 3, 4]. If end < start, you can return an empty array.
# # Write both a recursive and iterative version of sum of an array.
# def recursive_range(start_num, end_num)
#     return [] if end_num <= start_num
#     [start_num] + recursive_range(start_num + 1, end_num)
# end

# p recursive_range(1, 5)   #=> [1, 2, 3, 4]
# p recursive_range(5, 1)   #=> []
# puts '------'

# def iterative_range(start_num, end_num)
#     (start_num...end_num).to_a
# end

# p iterative_range(1, 5)   #=> [1, 2, 3, 4]
# p iterative_range(5, 1)   #=> []
# puts '--------------------------------------------------------------------------'


# # Exponentiation
# # Write two versions of exponent that use two different recursions:
# # this is math, not Ruby methods.

# # recursion 1
# #   - exp(b, 0) = 1
# #   - exp(b, n) = b * exp(b, n - 1)
# def exp1(base, power)
#     return 1 if power == 0
#     base * exp1(base, power - 1)
# end

# p exp1(1, 0)    #=> 1
# p exp1(1, 1)    #=> 1
# p exp1(1, 2)    #=> 1
# p exp1(2, 0)    #=> 1
# p exp1(2, 1)    #=> 2
# p exp1(2, 2)    #=> 4
# p exp1(5, 3)    #=> 125
# p exp1(8, 2)    #=> 64
# puts '------'

# # recursion 2
# #   - exp(b, 0) = 1
# #   - exp(b, 1) = b
# #   - exp(b, n) = exp(b, n / 2) ** 2             [for even n]
# #   - exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]
# def exp2(base, power)
#     return 1 if power == 0
#     exp2(base, power / 2) * exp2(base, power / 2) * (power.even? ? 1 : base)
# end

# p exp2(1, 0)    #=> 1
# p exp2(1, 1)    #=> 1
# p exp2(1, 2)    #=> 1
# p exp2(2, 0)    #=> 1
# p exp2(2, 1)    #=> 2
# p exp2(2, 2)    #=> 4
# p exp2(5, 3)    #=> 125
# p exp2(8, 2)    #=> 64
# puts '--------------------------------------------------------------------------'


# # Deep dup
# # The #dup method doesn't make a deep copy:
# # Using recursion and the #is_a? method, write an Array#deep_dup method 
# # that will perform a "deep" duplication of the interior arrays.
# # Note: For simplicity's sake, we are only going to ensure the deep duplication of arrays. 
# # Don't worry about deep-duping (or regular-duping) other types of mutable objects 
# # (like strings, hashes, instances of custom classes, etc.), 
# # since this would require that we implement a deep dup method for each of those classes, as well.
# # It's okay to iterate over array elements using the normal each for this one
# class Array
#     def deep_dup
#         self.map { |el| el.is_a?(Array) ? el.deep_dup : el }
#     end 
# end

# a = [1, [2], [3, [4]]]  #=> a = [1, [2], [3, [4]]]
# b = a.deep_dup          #=> b = [1, [2], [3, [4]]]
# b[2][1] << 5
# p a                     #=> a = [1, [2], [3, [4]]]
# p b                     #=> b = [1, [2], [3, [4, 5]]]
# puts '--------------------------------------------------------------------------'


# #Fibonacci
# # Write a recursive and an iterative Fibonacci method. 
# # The method should take in an integer n and return the first n Fibonacci numbers in an array.
# # You shouldn't have to pass any arrays between methods; 
# # you should be able to do this just passing a single argument for the number of Fibonacci numbers requested.
# # fibonacci sequence:  0, 1, 1, 2, 3, 5, 8, 13, 21, 34, ...

# def recursive_fibonacci(n)
#     return [0] if n == 1
#     return [0, 1] if n == 2
#     recursive_fibonacci(n - 1) << recursive_fibonacci(n - 1)[-2] + recursive_fibonacci(n - 1).last
# end

# p recursive_fibonacci(1)    #[0]
# p recursive_fibonacci(2)    #[0, 1]
# p recursive_fibonacci(3)    #[0, 1, 1]
# p recursive_fibonacci(4)    #[0, 1, 1, 2]
# p recursive_fibonacci(5)    #[0, 1, 1, 2, 3]
# p recursive_fibonacci(6)    #[0, 1, 1, 2, 3, 5]
# p recursive_fibonacci(7)    #[0, 1, 1, 2, 3, 5, 8]
# p recursive_fibonacci(8)    #[0, 1, 1, 2, 3, 5, 8, 13]
# p recursive_fibonacci(9)    #[0, 1, 1, 2, 3, 5, 8, 13, 21]
# p recursive_fibonacci(10)   #[0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
# puts '------'

# def iterative_fibonacci(n)
#     return [0] if n == 1
#     return [0, 1] if n == 2
#     seq = [0, 1]
#     seq << seq[-2] + seq.last until seq.length == n
#     seq
# end

# p iterative_fibonacci(1)    #[0]
# p iterative_fibonacci(2)    #[0, 1]
# p iterative_fibonacci(3)    #[0, 1, 1]
# p iterative_fibonacci(4)    #[0, 1, 1, 2]
# p iterative_fibonacci(5)    #[0, 1, 1, 2, 3]
# p iterative_fibonacci(6)    #[0, 1, 1, 2, 3, 5]
# p iterative_fibonacci(7)    #[0, 1, 1, 2, 3, 5, 8]
# p iterative_fibonacci(8)    #[0, 1, 1, 2, 3, 5, 8, 13]
# p iterative_fibonacci(9)    #[0, 1, 1, 2, 3, 5, 8, 13, 21]
# p iterative_fibonacci(10)   #[0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
# puts '--------------------------------------------------------------------------'

# #Binary Search
# # Write a recursive binary search: bsearch(array, target). 
# # Note that binary search only works on sorted arrays. 
# # Make sure to return the location of the found object (or nil if not found!). 
# # Hint: you will probably want to use subarrays.

# def bsearch(arr, target)
#     return nil if arr.empty?
#     mid = arr.length / 2
#     return mid if arr[mid] == target
#     arr[mid] > target ? bsearch(arr.take(mid), target) : (bsearch(arr.drop(mid+1), target).nil? ? nil : bsearch(arr.drop(mid+1), target) + mid + 1)
# end

# p bsearch([1, 2, 3], 1)             # => 0
# p bsearch([2, 3, 4, 5], 3)          # => 1
# p bsearch([2, 4, 6, 8, 10], 6)      # => 2
# p bsearch([1, 3, 4, 5, 9], 5)       # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6)    # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0)    # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6)    # => nil
# puts '--------------------------------------------------------------------------'


# #Merge Sort
# # Implement a method merge_sort that sorts an Array:
# # The base cases are for arrays of length zero or one. 
# # Do not use a length-two array as a base case. This is unnecessary.
# # You'll want to write a merge helper method to merge the sorted halves.
# # To get a visual idea of how merge sort works, watch this gif and check out this diagram.

# class Array
#     def merge_sort
#         return self if self.length < 2
#         mid = self.length / 2
#         merge(self.take(mid).merge_sort, self.drop(mid).merge_sort)
#     end

#     def merge(left, right)
#         merged = []
#         left.first <= right.first ? merged << left.shift : merged << right.shift until left.empty? || right.empty?
#         merged + left + right
#     end
# end
                
# p [].merge_sort             #=> []
# p [9].merge_sort            #=> [9]
# p [4,1,3,5,2].merge_sort    #=> [1, 2, 3, 4, 5]
# puts '--------------------------------------------------------------------------'


# # Array Subsets
# # Write a method subsets that will return all subsets of an array.
# # You can implement this as an Array method if you prefer.
# # Hint: For subsets([1, 2, 3]), there are two kinds of subsets:
# # Those that do not contain 3 (all of these are subsets of [1, 2]).
# # For every subset that does not contain 3, there is also a corresponding subset that is the same, except it also does contain 3.
# def subsets(arr)
#     return [[]] if arr.empty?
#     last_seq = subsets(arr.take(arr.length - 1))
#     last_seq + last_seq.map { |subArr| subArr + [arr.last] }
# end

# p subsets([]) # => [[]]
# p subsets([1]) # => [[], [1]]
# p subsets([1, 2]) # => [[], [1], [2], [1, 2]]           
# p subsets([1, 2, 3]) # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
# puts '--------------------------------------------------------------------------'


# #Permutations
# # Write a recursive method permutations(array) that calculates all the permutations of the given array. 
# # For an array of length n there are n! different permutations. 
# # So for an array with three elements we will have 3 * 2 * 1 = 6 different permutations.
# # You can use Ruby's built in Array#permutation method to get a better understanding of what you will be building.

# def permutations(arr)
#     return [arr] if arr.length < 2
#     last_seq = permutations(arr.drop(1))
#     permutated = []
#     last_seq.each { |subArr| (0..subArr.length).each { |i| permutated << subArr[0...i] + [arr.first] + subArr[i..-1] } }
#     permutated
# end

# p [].permutation.to_a          # => [[]]
# p permutations([])
                                
# p [1].permutation.to_a          # => [[1]]
# p permutations([1])

# p [1,2].permutation.to_a        # => [[1, 2], [2, 1]]
# p permutations([1, 2])
# puts '------'

# p [1,2,3].permutation.to_a      # => [  [1, 2, 3], [1, 3, 2],
#                                 #       [2, 1, 3], [2, 3, 1],
#                                 #       [3, 1, 2], [3, 2, 1]  ]
# p permutations([1, 2, 3])    
# puts '--------------------------------------------------------------------------'


# #Make Change
# # First, write a 'greedy' version called greedy_make_change:
# # Take as many of the biggest coin as possible and add them to your result.
# # Add to the result by recursively calling your method on the remaining amount, 
# # leaving out the biggest coin, until the remainder is zero.

# def make_change(amt, coins = [25, 10, 5, 1])
#     return [] if amt == 0
#     changes = []
#     changes << coins.first if coins.first <= amt
#     changes += (coins.first <= amt ? make_change(amt - coins.first, coins) : make_change(amt, coins.drop(1)))
#     changes
# end        

# p make_change(77)       #=> [25, 25, 25, 1, 1]
# p make_change(39)       #=> [25, 10, 1, 1, 1, 1]
# p make_change(24)       #=> [10, 10, 1, 1, 1, 1]
# p make_change(14)       #=> [10, 1, 1, 1, 1]
# p make_change(15)       #=> [10, 5]
# p make_change(8)        #=> [5, 1, 1, 1]
# p make_change(0)        #=> []
# puts '------'

# def make_change_2(amt, coins = [10, 7 ,1])     
#     return [] if amt == 0
#     best_changes = []

#     coins.each_with_index do |coin, i|
#         next if coin > amt
#         changes = [coin] + make_change_2(amt - coin, coins.drop(i))
#         best_changes = changes if best_changes.empty? || best_changes.count > changes.count
#     end

#     best_changes
# end   

# p make_change_2(77)     #=> [10, 10, 10, 10, 10, 10, 10, 7]
# p make_change_2(39)     #=> [10, 10, 10, 7, 1, 1]
# p make_change_2(24)     #=> [10, 7, 7]
# p make_change_2(14)     #=> [7, 7]
# p make_change_2(15)     #=> [7, 7, 1]
# p make_change_2(8)      #=> [7, 1]
# p make_change_2(0)      #=> []
# puts '--------------------------------------------------------------------------'