# Write a method range(min, max) that takes in two numbers min and max. 
# The method should return an array containing all numbers from min to max inclusive.

def range(min, max)
	arr =[]
  
  	(min..max).each { |num| arr  << num }
  
  	return arr
end

# def range(min, max)
# 	array = []
  	
#   	i = min
#   	while i <= max
#     	array << i
      	
#     	i += 1
#     end
  
#   	return array
# end

print range(2, 7)   # => [2, 3, 4, 5, 6, 7]
puts
print range(13, 20) # => [13, 14, 15, 16, 17, 18, 19, 20]