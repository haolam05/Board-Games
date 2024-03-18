# Write a method is_valid_name that takes in a string and returns a boolean 
# indicating whether or not it is a valid name.

# A name is valid is if satisfies all of the following:
# - contains at least a first name and last name, separated by spaces
# - each part of the name should be capitalized
#
# Hint: use str.upcase or str.downcase
# "a".upcase # => "A"

# def is_valid_name(str)
#   	if !str.include?(' ')
#       return false
#     end
  
#   	split = str.split(' ')
#   	split.each do | part |
#       if !(part[0].upcase == part[0] && part[1..-1].downcase == part[1..-1])
#         return false
#       end
#     end
  
#   	return true
# end

def is_valid_name(str)
  
  if !str.include?(' ')
    return false
  end
  
  str.split.each_with_index do |word, i|
    if word[0].upcase != word[0] || word[1..-1] != word[1..-1].downcase
      return false
    end
  end
  
  return true
end

puts is_valid_name("Kush Patel")       # => true
puts is_valid_name("Daniel")           # => false
puts is_valid_name("Robert Downey Jr") # => true
puts is_valid_name("ROBERT DOWNEY JR") # => false