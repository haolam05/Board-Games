# Write a method hand_score that takes in a string representing a hand of cards 
# and returns it's total score. You can assume the letters in the string are only 
# A, K, Q, J. A is worth 4 points, K is 3 points, Q is 2 points, and J is 1 point. 
# The letters of the input string not necessarily uppercase.

def hand_score(hand)
	score = 0
  
  	hash = { 'A' => 4, 'K' => 3, 'Q' => 2, 'J' => 1 }
  	hand.each_char { |char| score += hash[char.upcase] } 
  
  	return score
end
# def hand_score(hand)
# 	num = 0
  
#   	hand.each_char do |ele|
#       if ele == 'a'|| ele == 'A'
#         num += 4
#       elsif ele == 'k' || ele == 'K'
#         num += 3
#       elsif ele == 'q' || ele == 'Q'
#         num += 2
#       else
#         num += 1
#       end
#     end
  
#   	return num
# end

puts hand_score("AQAJ") #=> 11
puts hand_score("jJka") #=> 9