# Write a method odd_range(min, max) that takes in two numbers min and max. 
# The method should return an array containing all odd numbers from min to max 
# (inclusive).

def odd_range(min, max)
	arr = []
  
  	i = min
  	while i <= max
      if i % 2 == 1
        arr << i
      end
      
      i += 1
    end
  
  	return arr
end

# def odd_range(min, max)
# 	array = []
  	
#   	i = min
#   	while i <= max
#       if i % 2 == 1
#         array << i
#       end
      
#       i += 1
#     end
  
#   	return array
# end

print odd_range(11, 18) # => [11, 13, 15, 17]
puts
print odd_range(3, 7)   # => [3, 5, 7]