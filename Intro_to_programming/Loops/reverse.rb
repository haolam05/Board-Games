# Write a method reverse(word) that takes in a string word and 
# returns the word with its letters in reverse order.

# def reverse(word)
# 	reverse = ""
  
#  	i = 0
#   	while i < word.length
#       reverse = word[i] + reverse
#       i += 1
#     end
  
#   	return reverse
# end

def reverse(word)
	return word.reverse
end

# def reverse(word)
# 	reverse = ""
  
#  	i = word.length - 1
#   	while i >= 0
#       reverse += word[i]
#       i -= 1
#     end
  
#   	return reverse
# end

puts reverse("cat")          # => "tac"
puts reverse("programming")  # => "gnimmargorp"
puts reverse("bootcamp")     # => "pmactoob"