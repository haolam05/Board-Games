# Write a method to_initials that takes in a person's name string and 
# returns a string representing their initials.

def to_initials(name)
	arr_initial = name.split.map.with_index { |word| word[0] }
  	return arr_initial.join('')
end

# def to_initials(name)
# 	arr = name.split(' ')
#   	str = ''
# 	arr.each { |initial| str += initial[0] }
#   	return str
# end

puts to_initials("Kelvin Bridges")      # => "KB"
puts to_initials("Michaela Yamamoto")   # => "MY"
puts to_initials("Mary La Grange")      # => "MLG"