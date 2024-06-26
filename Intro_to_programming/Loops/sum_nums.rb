# Write a method sum_nums(max) that takes in a number max and 
# returns the sum of all numbers from 1 up to and including max.

def sum_nums(max)
	sum = 0	
  	(1..max).each { |num| sum += num }
  	return sum
end

puts sum_nums(4) # => 10, because 1 + 2 + 3 + 4 = 10
puts sum_nums(5) # => 15