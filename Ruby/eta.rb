n = 5000
puts "This is an average run-time of #{n} runs:"
# my_min
# Given a list of integers find the smallest number in the list.

# Phase I
# First, write a function that compares each element to every other element of the list. 
# Return the element if all other elements in the array are larger.
# What is the time complexity for this function?

# Phase II
# Now rewrite the function to iterate through the list just once while keeping track 
# of the minimum. What is the time complexity?

#1) 
def my_min_v1(list) 
    list.each do |n1|
        min = true
        list.each { |n2| min = false if n2 < n1 }
        return n1 if min
    end
end

puts "O(n^2) - time  #quadratic time"
puts "O(1)   - space #constant space"
times = []
n.times do
    t = Time.now
    my_min_v1([ 0, 3, 5, 4, -5, 10, 1, 90 ])  # =>  -5
    times << Time.now - t
end
puts "#{times.sum}"
puts "#{my_min_v1([ 0, 3, 5, 4, -5, 10, 1, 90 ])}\n\n"  # =>  -5

# 2) 
def my_min_v2(list)             
    list.min        #O(n) time, needs to iterate through array to find the minimum number
end

puts "O(n) - time   #linear time"
puts "O(1) - space  #constant space"
times = []
n.times do
    t = Time.now
    my_min_v2([ 0, 3, 5, 4, -5, 10, 1, 90 ])  # =>  -5
    times << Time.now - t
end
puts "#{times.sum}"
puts "#{my_min_v2([ 0, 3, 5, 4, -5, 10, 1, 90 ])}\n\n"  # =>  -5


# 3)    
def my_min_v3(list)
    min = list.first
    (1...list.length).each { |i| min = list[i] if list[i] < min }
    min
end

puts "O(n)   - time   #linear time"
puts "O(1) - space    #constant space"
times = []
n.times do
    t = Time.now
    my_min_v3([ 0, 3, 5, 4, -5, 10, 1, 90 ])  # =>  -5
    times << Time.now - t
end
puts "#{times.sum}"
puts "#{my_min_v3([ 0, 3, 5, 4, -5, 10, 1, 90 ])}\n\n"  # =>  -5


# 4)
def my_min_v4(list)
    min = nil

    list.each do |n1|  #O(n)
        copy = list.dup     #for each iteration: 
        copy.delete(n1)     
                            /O(n) time  - reassigning indices for all elements
                             O(n) space - because all elements are at different indcies each time due to delete(diff num each iteration)
                             even though copy just holds reference pointer toward the list.dup array, which is constant O(n) space
                             throughout the entire method, it is not true in this case because we delete different element each iteration
                             which causes the array to reassign indices for all elements. Since elements of list.dup array is at different
                             indices each iteration, we need space to hold them./
        min = n1 if list.none? { |n2| n2 < n1 }
    end

    min
end

puts "O(n^2)   - time   #quadratic time"
puts "O(n^2)   - space  #quadratic space"
times = []
n.times do
    t = Time.now
    my_min_v4([ 0, 3, 5, 4, -5, 10, 1, 90 ])  # =>  -5
    times << Time.now - t
end
puts "#{times.sum}"
puts "#{my_min_v4([ 0, 3, 5, 4, -5, 10, 1, 90 ])}\n\n"  # =>  -5



# Largest Contiguous Sub-sum
# You have an array of integers and you want to find the largest contiguous 
# (together in sequence) sub-sum. Find the sums of all contiguous sub-arrays 
# and return the max.

# Phase I
# Write a function that iterates through the array and finds all sub-arrays 
# using nested loops. First make an array to hold all sub-arrays. 
# Then find the sums of each sub-array and return the max.
# Discuss the time complexity of this solution.
# 1)
def all_subsets(arr)
    subs = []

    arr.each_index do |i|               #O(n) - time                          
        (i...arr.length).each do |j|    #O(n) - time
            subs << arr[i..j]           #O(n) - time    
        end                             #Array#slice is O(n)
    end                                 #array's elements are at different indices each tem << into subs, so O(n^3)

    subs
end

def largest_contiguous_subsum_v1(list)
    all_subsets(list).map(&:sum).max
end

puts  "O(n^3) - time   #cubic time"
puts  "O(n^3) - space  #cubic space"
times = []
n.times do
    t = Time.now
    largest_contiguous_subsum_v1([5, 3, -7]) 
    largest_contiguous_subsum_v1([2, 3, -6, 7, -6, 7]) 
    largest_contiguous_subsum_v1([-5, -1, -3])               
    times << Time.now - t
end
puts "#{times.sum}"
p largest_contiguous_subsum_v1([5, 3])           # =>  8
p largest_contiguous_subsum_v1([2, 3, -6, 7, -6, 7]) # =>  8
p largest_contiguous_subsum_v1([-5, -1, -3])         # => -1     
puts "\n"


# Phase II
# Let's make a better version. Write a new function using O(n) time with O(1) memory. 
# Keep a running tally of the largest sum. To accomplish this efficient space complexity, 
# consider using two variables. One variable should track the largest sum so far 
# and another to track the current sum. We'll leave the rest to you.
# 2)
def largest_contiguous_subsum_v2(list)
    largest_sum = list.first
    current_sum = list.first

    (1...list.length).each do |i|
        current_sum = 0 if current_sum < 0
        current_sum += list[i]
        largest_sum = current_sum if current_sum > largest_sum
    end

    largest_sum
end

puts  "O(n) - time   #linear time"
puts  "O(1) - space  #constant space"
times = []
n.times do
    t = Time.now
    largest_contiguous_subsum_v2([5, 3, -7]) 
    largest_contiguous_subsum_v2([2, 3, -6, 7, -6, 7]) 
    largest_contiguous_subsum_v2([-5, -1, -3])               
    times << Time.now - t
end
puts "#{times.sum}"
p largest_contiguous_subsum_v2([5, 3, -7])           # =>  8
p largest_contiguous_subsum_v2([2, 3, -6, 7, -6, 7]) # =>  8
p largest_contiguous_subsum_v2([-5, -1, -3])         # => -1     