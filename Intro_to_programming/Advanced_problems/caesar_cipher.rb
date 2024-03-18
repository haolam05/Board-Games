# Write a method caesar_cipher that takes in a string and a number. The method should return a new string
# where every character of the original is shifted num characters in the alphabet.

# Feel free to use this variable:
# alphabet = "abcdefghijklmnopqrstuvwxyz"

def caesar_cipher(str, num)
	new_str = ''
  	alphabet = "abcdefghijklmnopqrstuvwxyz"
  
  	str.each_char do |char|
      old_idx = alphabet.index(char)
      new_idx = (old_idx + num) % alphabet.length
      new_str += alphabet[new_idx]
    end
  
  	return new_str
end

# def caesar_cipher(str, num)
#   	shifted_str =	''
  
#   	alphabets = []
# 	'abcdefghijklmnopqrstuvwxyz'.each_char { |char| alphabets << char }
  	
#   	str.each_char do |char|
#       alphabets.each_with_index do |ele, idx|
#         if ele == char
#           shift_index = idx + num
#           if shift_index > 25
#             shift_index = shift_index - 26
#           end
#           shifted_str += alphabets[shift_index]
#         end
#       end
#     end
  	
#   	return shifted_str
# end

puts caesar_cipher("apple", 1)    #=> "bqqmf"
puts caesar_cipher("bootcamp", 2) #=> "dqqvecor"
puts caesar_cipher("zebra", 4)    #=> "difve"