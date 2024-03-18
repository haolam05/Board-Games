# Write a method sum_elements(arr1, arr2) that takes in two arrays. 
# The method should return a new array containing the results 
# of adding together corresponding elements of the original arrays. 
# You can assume the arrays have the same length.

def sum_elements(arr1, arr2)
	arr = []
  	
  	arr1.each_with_index do |ele, i|
      arr << arr1[i] + arr2[i]
	end
  	
  	return arr
end

# def sum_elements(arr1, arr2)
# 	new_arr = []
  
#   	i = 0
#   	while i < arr1.length
#       new_arr << arr1[i] + arr2[i]
  
#       i += 1
#     end
  
#   	return new_arr
# end

print sum_elements([7, 4, 4], [3, 2, 11])                            # => [10, 6, 15]
puts
print sum_elements(["cat", "pizza", "boot"], ["dog", "pie", "camp"]) # => ["catdog", "pizzapie", "bootcamp"]