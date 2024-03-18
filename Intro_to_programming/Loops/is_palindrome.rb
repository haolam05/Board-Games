# Write a method is_palindrome(word) that takes in a string word and 
# returns the true if the word is a palindrome, false otherwise. 
# A palindrome is a word that is spelled the same forwards and backwards.

# def is_palindrome(word)
# 	reverse = ''
  	
#   	i = word.length - 1
#   	while i >= 0
#       reverse += word[i]
#       i -= 1
#     end
  
#   	return reverse == word
# end

def is_palindrome(word)
  return word == word.reverse
end

puts is_palindrome("racecar")  # => true
puts is_palindrome("kayak")    # => true
puts is_palindrome("bootcamp") # => false