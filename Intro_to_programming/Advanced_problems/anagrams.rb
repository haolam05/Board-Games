# Write a method anagrams? that takes in two words and returns a boolean indicating whether or not 
# the words are anagrams. Anagrams are words that contain the same characters but not necessarily 
# in the same order. Solve this without using .sort

def anagrams?(word1, word2)
	return ana(word1) == ana(word2)
end

def ana(word)
	hash = Hash.new(0)
  	word.each_char { |char| hash[char] += 1}
  	return hash
end

puts anagrams?("cat", "act")          #=> true
puts anagrams?("restful", "fluster")  #=> true
puts anagrams?("cat", "dog")          #=> false
puts anagrams?("boot", "bootcamp")    #=> false