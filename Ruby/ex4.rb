#Problem 1: You have array of integers. Write a recursive solution to find the sum of the integers.
def sum_recur(arr)

end

p sum_recur([])             #=> nil
p sum_recur([4])            #=> 4
p sum_recur([2,4,12])       #=> 18
p sum_recur([22,44,11])     #=> 77
puts "--------------------------------------------------------------------------"


#Problem 2: You have array of integers. Write a recursive solution to determine whether or not the array contains a specific value.
def includes?(arr, target)

end

p includes?([], 3)                  #=> false
p includes?([1], 2)                 #=> false
p includes?([2], 2)                 #=> true
p includes?([11,22,33,44], 15)      #=> false
p includes?([11,22,33,44], 22)      #=> true
puts "--------------------------------------------------------------------------"


# Problem 3: You have an unsorted array of integers. Write a recursive solution to count the number of occurrences of a specific value.
def num_occur(arr, target)

end

# def num_occur(arr, target)
#     arr.map { |num| num == target ? 1 : 0 }.sum
# end

p num_occur([1,2,3,2,2,2,1,1,3], 2)   #=> 4
p num_occur([1,2,3,2,2,2,1,1,3], 1)   #=> 3
p num_occur([1,2,3,2,2,2,1,1,3], 3)   #=> 2
p num_occur([1], 1)                   #=> 1
p num_occur([], 1)                    #=> 0
puts "--------------------------------------------------------------------------"


# Problem 4: You have array of integers. Write a recursive solution to determine whether or not two adjacent elements of the array add to 12.
def add_to_twelve?(arr)

end

p add_to_twelve?([])                #=> false
p add_to_twelve?([12])              #=> false
p add_to_twelve?([3,4])             #=> false
p add_to_twelve?([6,6,9])           #=> true
p add_to_twelve?([9,6,6,3,9])       #=> true
p add_to_twelve?([0,10,12,2,10])    #=> true
puts "--------------------------------------------------------------------------"


# Problem 5: You have array of integers. Write a recursive solution to determine if the array is sorted.
def sorted?(arr)

end

p sorted?([1,2,4,3])            #=> false
p sorted?([4,3,2,1])            #=> false
p sorted?([3,2,1,4])            #=> false
p sorted?([1,2,3,4])            #=> true
p sorted?([1,2,3,5])            #=> true
p sorted?([6,9,100,99999999])   #=> true
p sorted?([])                   #=> true
p sorted?([10])                 #=> true
puts "--------------------------------------------------------------------------"


# Problem 6: Write a recursive function to reverse a string. Don't use any built-in #reverse methods!
def reverse(str)

end

p reverse("")                   #=> ""
p reverse("a")                  #=> "a"          
p reverse("string")             #=> "gnirts"          
p reverse("bob")                #=> "bob"
p reverse("hao")                #=> "oah"
puts "--------------------------------------------------------------------------"







# #Problem 1: You have array of integers. Write a recursive solution to find the sum of the integers.
# def sum_recur(arr)
#     return arr.first if arr.length < 2
#     arr.first + sum_recur(arr.drop(1))
# end

# p sum_recur([])             #=> nil
# p sum_recur([4])            #=> 4
# p sum_recur([2,4,12])       #=> 18
# p sum_recur([22,44,11])     #=> 77
# puts "--------------------------------------------------------------------------"


# #Problem 2: You have array of integers. Write a recursive solution to determine whether or not the array contains a specific value.
# def includes?(arr, target)
#     return false if arr.empty?
#     arr.first == target ? true : includes?(arr.drop(1), target)
# end

# p includes?([], 3)                  #=> false
# p includes?([1], 2)                 #=> false
# p includes?([2], 2)                 #=> true
# p includes?([11,22,33,44], 15)      #=> false
# p includes?([11,22,33,44], 22)      #=> true
# puts "--------------------------------------------------------------------------"


# # Problem 3: You have an unsorted array of integers. Write a recursive solution to count the number of occurrences of a specific value.
# def num_occur(arr, target)
#     return 0 if arr.length < 1
#     (arr.first == target ? 1 : 0) + num_occur(arr.drop(1), target)
# end

# # def num_occur(arr, target)
# #     arr.map { |num| num == target ? 1 : 0 }.sum
# # end

# p num_occur([1,2,3,2,2,2,1,1,3], 2)   #=> 4
# p num_occur([1,2,3,2,2,2,1,1,3], 1)   #=> 3
# p num_occur([1,2,3,2,2,2,1,1,3], 3)   #=> 2
# p num_occur([1], 1)                   #=> 1
# p num_occur([], 1)                    #=> 0
# puts "--------------------------------------------------------------------------"


# # Problem 4: You have array of integers. Write a recursive solution to determine whether or not two adjacent elements of the array add to 12.
# def add_to_twelve?(arr)
#     return false if arr.length < 2
#     arr[0] + arr[1] == 12 ? true : add_to_twelve?(arr.drop(1))
# end

# p add_to_twelve?([])                #=> false
# p add_to_twelve?([12])              #=> false
# p add_to_twelve?([3,4])             #=> false
# p add_to_twelve?([6,6,9])           #=> true
# p add_to_twelve?([9,6,6,3,9])       #=> true
# p add_to_twelve?([0,10,12,2,10])    #=> true
# puts "--------------------------------------------------------------------------"


# # Problem 5: You have array of integers. Write a recursive solution to determine if the array is sorted.
# def sorted?(arr)
#     return true if arr.length < 2
#     arr[0] > arr[1] ? false : sorted?(arr.drop(1))
# end

# p sorted?([1,2,4,3])            #=> false
# p sorted?([4,3,2,1])            #=> false
# p sorted?([3,2,1,4])            #=> false
# p sorted?([1,2,3,4])            #=> true
# p sorted?([1,2,3,5])            #=> true
# p sorted?([6,9,100,99999999])   #=> true
# p sorted?([])                   #=> true
# p sorted?([10])                 #=> true
# puts "--------------------------------------------------------------------------"


# # Problem 6: Write a recursive function to reverse a string. Don't use any built-in #reverse methods!
# def reverse(str)
#     return str if str.length < 2
#     str[-1] + reverse(str[0..-2])
# end

# p reverse("")                   #=> ""
# p reverse("a")                  #=> "a"          
# p reverse("string")             #=> "gnirts"          
# p reverse("bob")                #=> "bob"
# p reverse("hao")                #=> "oah"
# puts "--------------------------------------------------------------------------"