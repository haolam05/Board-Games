# Write a method longer_string(str1, str2) that takes in two strings and returns the longer of the two strings. 
# In the case of a tie, the method should return the first string.

def longer_string(str1, str2)
	if str2.length > str1.length
      return str2
    end
 	return str1
end

puts longer_string("app", "academy") # => "academy"
puts longer_string("summer", "fall") # => "summer"
puts longer_string("hello", "world") # => "hello"