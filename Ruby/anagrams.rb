# Our goal today is to write a method that determines if two given words are anagrams. 
# This means that the letters in one word can be rearranged to form the other word. 
# Assume that there is no whitespace or punctuation in the given strings.

# Phase I:
# Write a method #first_anagram? 
# that will generate and store all the possible anagrams of the first string. 
# Check if the second string is one of these.
def first_anagram?(str1, str2)
    all_anagrams(str1).include?(str2)
end
                                                                      
def all_anagrams(str)                                                   
    return [str] if str.length < 2
    prev_anagram = all_anagrams(str[1..-1])    
    next_anagram = []

    prev_anagram.each do |anagram|
        (0..anagram.length).each do |i|
            next_anagram << anagram.dup.insert(i, str[0])
        end
    end
                     
    next_anagram
end                                                                     
             
# all_anagrams(["long")        
#     prev_anagram = all_anagrams("ong")                                ====
#     next_anagram = []                                                   ||
#     prev_anagram.each do |anagram|                                      ||
#         (0..anagram.length).each do |i|                                 ||
#             next_anagram << anagram.dup.insert(i, str[0])               ||
#         end                                                             ||
#     end                                                                 ||
#     next_anagram                                                        ||
#                                                                         \/
#                                                                 all_anagrams("ong") 
#                                                                     prev_anagram = all_anagrams(["ng"])                          =========
#                                                                     next_anagram = []                                                   ||
#                                                                     prev_anagram.each do |anagram|                                      ||
#                                                                         (0..anagram.length).each do |i|                                 ||
#                                                                             next_anagram << anagram.dup.insert(i, str[0])               ||
#                                                                         end                                                             ||
#                                                                     end                                                                 ||
#                                                                     next_anagram                                                        \/
#                                                                                                                             all_anagrams(["ng"])
#                                                                                                                                 prev_anagram = all_anagrams(["g"])                          =========
#                                                                                                                                 next_anagram = []                                                   ||
#                                                                                                                                 prev_anagram.each do |anagram|                                      ||
#                                                                                                                                     (0..anagram.length).each do |i|                                 ||
#                                                                                                                                         next_anagram << anagram.dup.insert(i, str[0])               ||
#                                                                                                                                     end                                                             ||
#                                                                                                                                 end                                                                 ||
#                                                                                                                                 next_anagram                                                        \/                                                                            
#                                                                                                                                                                                             all_anagrams(["g"])
#                                                                                                                                                                                                 ["g"]
                                                                                                                                                                                            





puts "Time complexity:  O(n!)  - factorial time"
puts "Space complexity: O(n!)  - factorial space" 
puts "As the string increases by 1 character, there is another nested loop for every possible choices."
t = Time.now
p first_anagram?("gizmo", "sally")    #=> false
p first_anagram?("elvis", "lives")    #=> true
p Time.now - t

# 'long':           n! = 4! = 4 * 3 * 2 * 1 = 24 choices
#     prev_anagram = ["ong", "ogn", "nog", "ngo", "gon", "gno"]
# next_anagram:     for every word in arr, insert 'l' into every possible pos 
#    ["ong"]   =>   ["long", "olng", "onlg", "ongl"]
#    ["ogn"]   =>   ["logn", "olgn", "ogln", "ognl"]
#    ["nog"]   =>   ["lnog", "nlog", "nolg", "nogl"]
#    ["ngo"]   =>   ["lngo", "nlgo", "nglo", "ngol"]
#    ["gon"]   =>   ["lgon", "glon", "goln", "gonl"]
#    ["gno"]   =>   ["lgno", "glno", "gnlo", "gnol"]
# nested loop for each of the word is 4: inserted 'l' at index 0,1,2,3

# 'hao':           n! = 3! = 3 * 2 * 1 = 6 choices
#     prev_anagram = ["ao", "oa"]
# next_anagram:    for every word in arr, insert 'h' into every possible pos 
#    ["ao"]   =>   ["hao", "aho", "aoh"]
#    ["oa"]   =>   ["hoa", "oha", "oah"]
# nested loop for each of the word is 3: inserted 'h' at index 0,1,2

# => as the string increases in size, 1 more char = 1 more nested loop



# Phase II:
# Write a method #second_anagram? that iterates over the first string. 
# For each letter in the first string, find the index of that letter in the second 
# string (hint: use Array#find_index) and delete at that index. The two strings 
# are anagrams if an index is found for every letter and the second string is 
# empty at the end of the iteration.
# Try varying the length of the input strings. 
# What are the differences between #first_anagram? and #second_anagram??
def second_anagram?(str1, str2)
    arr1, arr2 = str1.split(''), str2.split('') #O(n) - time    O(n) - space

    arr1.each do |char|             #O(n) - time
        idx = arr2.index(char)      #O(n) - time iterate thru arr to find char then returns idx
        return false if idx.nil?
        arr2.delete_at(idx)         #O(n) - time reassigning indices 
    end
    
    arr2.empty?
end

puts "Time complexity:  O(n^2) - quadratic time"
puts "Space complexity: O(n)   - linear space" 
t = Time.now
p second_anagram?("gizmo", "sally")    #=> false
p second_anagram?("elvis", "lives")    #=> true
p Time.now - t


# Phase III:
# Write a method #third_anagram? that solves the problem by sorting both strings alphabetically. 
# The strings are then anagrams if and only if the sorted versions are the identical.
# What is the time complexity of this solution? Is it better or worse than #second_anagram??
def third_anagram?(str1, str2)
    str1.split('').sort == str2.split('').sort      #O(nlogn) - time. quicksort, best possible case
end #space: #O(n) O(n) O(1)    O(n)       O(n)      #O(n)     - time, split('')
    #space O(1) if uses sort!

puts "Time complexity:  O(nlogn) - linearithmic time"
puts "Space complexity: O(n)     - linear space" 
t = Time.now
p third_anagram?("gizmo", "sally")    #=> false
p third_anagram?("elvis", "lives")    #=> true
p Time.now - t



# Phase IV:
# Write one more method #fourth_anagram?. This time, use two Hashes to store the 
# number of times each letter appears in both words. Compare the resulting hashes.
# What is the time complexity?
def fourth_anagram?(str1, str2) 
    hash1 = Hash.new(0)
    hash2 = Hash.new(0)
    str1.each_char { |char| hash1[char] += 1 }  #O(n) - time    O(1) - space, becasue only 26 letters + numbers and symbols for English alphabet
    str2.each_char { |char| hash2[char] += 1 }  #O(n) - time    O(1) - space, because only 26 letters + numbers and symbols for English alphabet
    hash1 == hash2
end

# Here, the intuitive answer to the space complexity is
# O(n) because we're adding a separate key in the hash
# for each character. But if the keys in the hash are single 
# characters, then how many different keys can we have? 
# How many different chars in the alphabet? A constant number 
# (26 + numbers and symbols for English alphabet).

puts "Time complexity:  O(n)   - linear time"
puts "Space complexity: O(1)   - constant space" 
t = Time.now
p fourth_anagram?("gizmo", "sally")    #=> false
p fourth_anagram?("elvis", "lives")    #=> true
p Time.now - t



#Bonus: Do it with only one hash.
def fourth_anagram_one_hash?(str1, str2)
    hash = Hash.new(0)                          #O(1) - space, limited number of letters and symbols
    str1.each_char { |char| hash[char] += 1 }   #O(n) - time
    str2.each_char { |char| hash[char] -= 1 }   #O(n) - time
    hash.values.all?(0)
end

puts "Time complexity:  O(n)   - linear time"
puts "Space complexity: O(1)   - constant space" 
t = Time.now
p fourth_anagram_one_hash?("gizmo", "sally")    #=> false
p fourth_anagram_one_hash?("elvis", "lives")    #=> true
p Time.now - t




    