# Write a method element_count that takes in an array and returns a hash 
# representing the count of each element in the array.

def element_count(arr)
	hash = Hash.new(0)
  	arr.each { |ele| hash[ele] += 1 }
  	return hash
end

puts element_count(["a", "b", "a", "a", "b"]) #=> {"a"=>3, "b"=>2}
puts element_count(["red", "red", "blue", "green"]) #=> {"red"=>2, "blue"=>1, "green"=>1}