# Write a method doubler(numbers) that takes an array of numbers and returns 
# a new array where every element of the original array is multiplied by 2.

def doubler(numbers)
	return numbers.map { |num| num * 2 }
end

# def doubler(numbers)
# 	new_arr = []
  	
#   	i = 0
#   	while i < numbers.length
#       new_arr<< numbers[i] * 2
      
#       i += 1
#     end
	
#   	return new_arr
# end

print doubler([1, 2, 3, 4]) # => [2, 4, 6, 8]
puts
print doubler([7, 1, 8])    # => [14, 2, 16]