# Write a method unique_elements that takes in an array and returns a new array 
# where all duplicate elements are removed. Solve this using a hash.

# Hint: all keys of a hash are automatically unique

def unique_elements(arr)
  	hash = Hash.new(0)
  	arr.each { |letter| hash[letter] += 1 }
	return hash.keys
end

print unique_elements(['a', 'b', 'a', 'a', 'b', 'c']) #=> ["a", "b", "c"]
puts