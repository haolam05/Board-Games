# Write a method factorial(num) that takes in a number num and 
# returns the product of all numbers from 1 up to and including num.

def factorial(num)
	factorial = 1
  	(2..num).each { |n| factorial *= n}
  	return factorial
end

puts factorial(3) # => 6, because 1 * 2 * 3 = 6
puts factorial(5) # => 120, because 1 * 2 * 3 * 4 * 5 = 120