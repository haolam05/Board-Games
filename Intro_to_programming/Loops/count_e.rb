# Write a method count_e(word) that takes in a string word and returns
# the number of e's in the word

def count_e(word)
	count = 0
  
  	word.each_char do |char|
      if char == 'e'
        count += 1
      end
    end
  
  	return count
end

puts count_e("movie") # => 1
puts count_e("excellent") # => 3