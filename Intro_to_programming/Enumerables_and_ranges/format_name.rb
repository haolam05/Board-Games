# Write a method format_name that takes in a name string and returns the name 
# properly capitalized.

# Hint: use str.upcase and str.downcase
# "abc".upcase # => "ABC"

def format_name(str)
	new_arr = str.split.map.with_index { |word, i| word[0].upcase + word[1..-1].downcase }   
  	return new_arr.join(' ')
end

# def format_name(str)
# 	split = str.split(' ')
#   	arr = []
  
#   	split.each { |word| arr << word[0].upcase + word[1..-1].downcase }
  	
#   	return arr.join(' ')
# end

puts format_name("chase WILSON") # => "Chase Wilson"
puts format_name("brian CrAwFoRd scoTT") # => "Brian Crawford Scott"