# Write a method most_vowels that takes in a sentence string and returns the word of the sentence 
# that contains the most vowels.

# def most_vowels(sentence)
#   	hash = {}

#   	sentence.split.each do |word| 	
# 		hash[word] = 0
#     end
#   	#{"what"=>0, "a"=>0, "wonderful"=>0, "life"=>0}
  
#   	hash.each_key do |word|
#       word.each_char do |char|
#         if 'aoeui'.include?(char)
#         	hash[word] += 1
#         end
#       end
#     end	
#   	#goal: {"what"=>1, "a"=>1, "wonderful"=>3, "life"=>2}
  	
#   	double_arr = hash.sort_by { |k, v| v}	
#   	#[["what", 1], ["a", 1], ["life", 2], ["wonderful", 3]]
  
#   	return double_arr[-1][0]	
#   	#	   double_arr[3][0] == wonderful
# end

# def most_vowels(sentence)
#   hash = {}
#   sentence.split.each { |word| hash[word] = vowels_count(word) }
#   sorted_2Darr = hash.sort_by { |k,v| v }
#   return sorted_2Darr[-1][0]
# end

# def vowels_count(word)
#   count = 0
  
#   word.each_char do |char|
#     if 'aeiou'.include?(char)
#       count += 1
#     end
#   end
  
#   return count
# end

def most_vowels(sentence)
  hash = Hash.new(0)
  sentence.split.each { |word| hash[word] = vowel_count(word) }
  return hash.sort_by { |k, v| v }[-1][0]
end

def vowel_count(word)
  count = 0
  word.each_char do |char|
  	if 'aeiou'.include?(char)
      count += 1
    end
  end
  return count
end

print most_vowels("what a wonderful life") #=> "wonderful"