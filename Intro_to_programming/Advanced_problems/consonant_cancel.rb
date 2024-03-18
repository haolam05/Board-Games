# Write a method consonant_cancel that takes in a sentence and returns a new sentence where every word 
# begins with it's first vowel.

def consonant_cancel(sentence)
	return sentence.split.map { |word| start_with_vowel1(word) }.join(' ')
end

def start_with_vowel1(word)
  word.each_char.with_index do |char, i|
    if 'aeiou'.include?(char)
      return word[i..-1]
    end
  end
end

# def consonant_cancel(sentence)
#   	arr = []
#   	sentence.split.map do |word|
#       word.each_char.with_index do |char, i|
#         if 'aeiou'.include?(char)
#           word[i..-1]
#           break
#         end
#       end
#     end
  
#   	return arr.join(' ')
# end

puts consonant_cancel("down the rabbit hole") #=> "own e abbit ole"
puts consonant_cancel("writing code is challenging") #=> "iting ode is allenging"