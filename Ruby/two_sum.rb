# two_sum?
# Given an array of unique integers and a target sum, determine whether 
# any two integers in the array sum to that amount.
def bad_two_sum?(arr, target_sum) #O(1) - space
  arr.each_with_index do |n1, i|                                              #O(n) - time
    (i+1...arr.length).each { |j| return true if target_sum == n1 + arr[j] }  #O(n) - time
  end

  false
end

# Write a second solution, called okay_two_sum?, which uses sorting. Make sure it works correctly.
# Hint: (There are a couple ways to solve this problem once it's sorted. One way involves using a very 
# cheap algorithm that can only be used on sorted data sets. What are some such algorithms you know?)
def okay_two_sum_v1?(arr, target_sum)
  arr, i, j = arr.sort, 0, arr.length - 1   #O(n) - space,  Array#sort
                                            #O(nlogn) - time Array#sort => quicksortm best possible case
  while i < j       #O(n) - time
    result = arr[i] + arr[j]
    return true if result == target_sum
    result < target_sum ? i += 1 : j -= 1
  end

  false
end

# another implementation using binary search
def okay_two_sum_v2?(arr, target_sum)
  arr = arr.sort

  arr.each_with_index do |el, i| #search index of an element in array. That element must meet this condition: has target_sum - el == el2
    match_idx = arr.bsearch_index { |el2| (target_sum - el) <=> el2 } #O(nlogn) - time, binary search is logn, outer loop is n
    return true if match_idx && match_idx != i
  end

  false
end

def two_sum?(arr, target_sum)
  two_sum = {}

  arr.each do |n|
    return true if two_sum[target_sum - n]
    two_sum[n] = true
  end

  false
end

#This can be easily adapted to also return the indices of the two numbers:
def two_sum_indices(arr, target_sum)
  two_sum = {}

  arr.each_with_index do |n, i|
    difference, j = two_sum[target_sum - n] # these will both be nil if the complement doesn't exist
    return [i, j] if difference
    two_sum[n] = [n, i]
  end

  nil
end

def four_sum?(arr, target_sum)
  one_sum, two_sum, three_sum = {}, {}, {}    #O(n^2) - space

  arr.each do |n| #O(n) -time
    # return true if three_sum[target_sum - n]
    two_sum.each_key { |key| three_sum[key + n] = true }  #O(n) -time
    one_sum.each_key { |key| two_sum[key + n] = true }    #O(n) -time
    one_sum[n] = true
  end

  false
end      

# Assume array has unique elements and no sum is overlap (worst case), then:
#     1) one_sum   - space : n 
#     2) two_sum   - space : [ (n1)^2 - n1 ] / 2    => O(n^2)

# 1 4 6 10 20 35 56 84 120

arr =  [0, 1, 5, 7]
arr2 = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]


puts "Time Complexity:   O(n^2)  - quadratic time\nSpace Complexity:  O(1)    - constant space"
t = Time.now
p bad_two_sum?(arr, 6)              #true
p bad_two_sum?(arr, 10)             #false
puts "#{Time.now - t}\n\n"

puts "Time Complexity:   O(nlogn)  -  linearithmic time\nSpace Complexity:  O(n)    -  linear space"
t = Time.now
p okay_two_sum_v1?(arr, 6)          #true
p okay_two_sum_v1?(arr, 10)         #false
puts "#{Time.now - t}\n\n"

puts "Time Complexity:   O(nlogn)- linearithmic time\nSpace Complexity:  O(n)    - linear space"
t = Time.now
p okay_two_sum_v2?(arr, 6)          #true
p okay_two_sum_v2?(arr, 10)         #false
puts "#{Time.now - t}\n\n"

puts "Time Complexity:   O(n)    - linear time\nSpace Complexity:  O(n)    - linear space"
t = Time.now
p two_sum?(arr, 6)                  #true
p two_sum?(arr, 10)                 #false
puts "#{Time.now - t}\n\n"

puts "Time Complexity:   O(n)    - linear time\nSpace Complexity:  O(n)    - linear space"
t = Time.now
p two_sum_indices(arr, 6)           #true
p two_sum_indices(arr, 10)          #false
puts "#{Time.now - t}\n\n"

puts "Time Complexity:   O(n^2)  - quadratic time\nSpace Complexity:  O(n^2)  - quadratic space"
t = Time.now
p four_sum?(arr, 8)                 #false
p four_sum?(arr, 13)                #true
puts "#{Time.now - t}\n\n"
# t = Time.now
# p four_sum?(arr2, 25)               #false
# p four_sum?(arr2, 50)               #true
# puts "#{Time.now - t}\n\n"
