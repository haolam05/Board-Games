# Write a method pig_latin_word that takes in a word string and 
# translates the word into pig latin.

# Pig latin translation uses the following rules:
# - for words that start with a vowel, add 'yay' to the end
# - for words that start with a nonvowel, move all letters before the first vowel to the end of the word and add 'ay'

def pig_latin_word(word)
  if 'aeiou'.include?(word[0])
    return word + 'yay'
  end
    
   word.each_char.with_index do |char, i|
     if 'aeiou'.include?(char)
       return word[i..-1] + word[0...i] + 'ay'
     end
   end
end

# def pig_latin_word(word)
#   if 'aeiou'.include?(word[0])
#     return word + 'yay'
#   else
#     return start_w_vowel(word) + 'ay'
#   end
# end

# def start_w_vowel(word)
#   str = ''
  
#   word.each_char.with_index do |char, i|
#   	if 'aeiou'.include?(char)
#       str += word[i..-1] + word[0...i]
#       break
#     end
#   end
  
#   return str
# end
def pig_latin_word(word)

  first_letter = word[0]
  vowel = "aeiou"
  if vowel.include?(first_letter)
    new_word = word + "yay"
  
  else
    new_word = no_vowel(word)

    
  end
  return new_word
end

def no_vowel(word)

  i=0
  letters = ""
 
  vowels = "aeiou"
  while !vowels.include?(word[i])
	letter = word[i]
    letters << word[i]
    new_word = word[i+1..-1] + letters + "ay"
    i += 1
  end
  return  new_word 
end


puts pig_latin_word("apple")   # => "appleyay"
puts pig_latin_word("eat")     # => "eatyay"
puts pig_latin_word("banana")  # => "ananabay"
puts pig_latin_word("trash")   # => "ashtray"