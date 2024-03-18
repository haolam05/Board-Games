# Write a method abbreviate_sentence that takes in a sentence string and 
# returns a new sentence where every word longer than 4 characters has all of 
# it's vowels removed.

def abbreviate_sentence(sent)
  new_arr =  sent.split.map do |word|
    if word.length > 4
      abbreviated(word)
    else
      word
    end
  end
  
  return new_arr.join(' ')
end

def  abbreviated(word)
  str = ''
  
  word.each_char do |char|
    if !'aeiou'.include?(char)
      str += char
    end
  end
  
  return str
end

# def abbreviate_sentence(sent)
# 	arr = sent.split(' ')
#   	new_version = []	
  
#   	arr.each do |word|
#       if word.length > 4
		
#         new_word = ''
#         word.each_char do |char|
#           if !'aoeui'.include?(char)
#             new_word += char
#           end
#         end
        
#         new_version << new_word
#       else
#         new_version << word
#       end
        
#     end
  
#   	return new_version.join(' ')
# end

# def abbreviate_sentence(sent)
# 	arr = sent.split(' ')
#   	new_version = []	
  
#   	arr.each do |word|
      
#       if word.length > 4
        
# 		new_word = remove_vowels(word)
#         new_version << new_word
#       else
        
#         new_version << word
#       end
        
#     end
  
#   	return new_version.join(' ')
# end

# def remove_vowels(word)
#   new_Word = ''
  
#   word.each_char do|char|
# 	if !'aoeui'.include?(char)
#       new_Word += char
#     end
#   end
    
#   return new_Word
# end

puts abbreviate_sentence("follow the yellow brick road") # => "fllw the yllw brck road"
puts abbreviate_sentence("what a wonderful life")        # => "what a wndrfl life"
