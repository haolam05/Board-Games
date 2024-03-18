# Write a method vowel_cipher that takes in a string and returns a new string where every vowel becomes 
# the next vowel in the alphabet.

def vowel_cipher(string)
	new_str = ''
  	vowels = 'aeiou'

	string.each_char do |char|
    	if vowels.include?(char)
          new_str += new_char(char, vowels)
        else
          new_str += char
        end
    end
  
  	return new_str
end

def new_char(char, vowels)
  old_idx = vowels.index(char)
  new_idx = (old_idx + 1) % vowels.length
  return vowels[new_idx]
end

puts vowel_cipher("bootcamp") #=> buutcemp
puts vowel_cipher("paper cup") #=> pepir cap