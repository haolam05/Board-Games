# Write a method prime_factors that takes in a number and returns an array containing all 
# of the prime factors of the given number.

def prime_factors(num)
	arr = []
  
  	(2..num).each do |factor|
    	if num % factor == 0
          arr << factor
        end
    end
  	
  	return arr.select { |num| prime(num) }
end

def prime(num)
  	(2...num).each do |div|
    	if num % div == 0
          return false
        end
    end
  
	return true
end

print prime_factors(24) #=> [2, 3]
puts
print prime_factors(60) #=> [2, 3, 5]
puts

# 24: 1 2 3 4 6 8 12 24
# 2: 1 2