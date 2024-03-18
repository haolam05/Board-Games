#GENERAL PROBLEMS
# no_dupes?
# Write a method no_dupes?(arr) that accepts an array as an arg and returns an new array containing the elements that were not repeated in the array.

def no_dupes?(arr)
    hash = Hash.new(0)
    arr.each { |el| hash[el] += 1 }
    hash.keys.select { |key| hash[key] == 1 }
end

# Examples
p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
p no_dupes?([true, true, true])            # => []
puts "----------"


# p no_consecutive_repeats?
# Write a method no_consecutive_repeats?(arr) that accepts an array as an arg. The method should return true if an element never appears consecutively in 
# the array; it should return false otherwise.

def no_consecutive_repeats?(arr)
    (0...arr.length - 1).none? { |i| arr[i] == arr[i+1] }
end

# Examples
p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
p no_consecutive_repeats?(['x'])                              # => true
puts "----------"


# char_indices
# Write a method char_indices(str) that takes in a string as an arg. The method should return a hash containing characters as keys. 
# The value associated with each key should be an array containing the indices where that character is found.

def char_indices(str)
    hash = Hash.new { |h, k| h[k] = [] }
    str.each_char.with_index { |char, i| hash[char] << i }
    hash
end

# Examples
p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}
puts "----------"

# longest_streak
# Write a method longest_streak(str) that accepts a string as an arg. The method should return the longest streak of consecutive characters in the string. 
# If there are any ties, return the streak that occurs later in the string.

def longest_streak(str)
    hash = {}

    i = 0
    while i < str.length
        count = 1
        while str[i] == str[i+1]
            count += 1
            i += 1
        end

        hash[str[i]] = count
        i += 1
    end
    
    sorted = hash.sort_by { |k, v| v }
    sorted.last[0] * sorted.last[1]
end

# Examples
p longest_streak('a')           # => 'a'
p longest_streak('accccbbb')    # => 'cccc'
p longest_streak('aaaxyyyyyzz') # => 'yyyyy
p longest_streak('aaabbb')      # => 'bbb'
p longest_streak('abc')         # => 'c'
puts "----------"

# bi_prime?
# Write a method bi_prime?(num) that accepts a number as an arg and returns a boolean indicating whether or not the number is a bi-prime. 
# A bi-prime is a positive integer that can be obtained by multiplying two prime numbers.

# For Example:

# 14 is a bi-prime because 2 * 7
# 22 is a bi-prime because 2 * 11
# 25 is a bi-prime because 5 * 5
# 24 is not a bi-prime because no two prime numbers have a product of 24

def bi_prime?(num)
    primes = (2...num).to_a.select { |n| prime?(n) }
    (0...primes.length).any? do |i| 
        (i...primes.length).any? { |j| primes[i] * primes[j] == num }
    end
end

def prime?(num)
    (2...num).none? { |i| num % i == 0 }
end

# Examples
p bi_prime?(14)   # => true
p bi_prime?(22)   # => true
p bi_prime?(25)   # => true
p bi_prime?(94)   # => true
p bi_prime?(24)   # => false
p bi_prime?(64)   # => false
puts "----------"


# vigenere_cipher
# A Caesar cipher takes a word and encrypts it by offsetting each letter in the word by a fixed number, called the key. Given a key of 3, 
# for example: a -> d, p -> s, and y -> b.

# A Vigenere Cipher is a Caesar cipher, but instead of a single key, a sequence of keys is used. For example, if we encrypt "bananasinpajamas" with 
# the key sequence 1, 2, 3, then the result would be "ccqbpdtkqqcmbodt":

# Message:  b a n a n a s i n p a j a m a s
# Keys:     1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1
# Result:   c c q b p d t k q q c m b o d t
# Write a method vigenere_cipher(message, keys) that accepts a string and a key-sequence as args, returning the encrypted message. 
# Assume that the message consists of only lowercase alphabetic characters.

def vigenere_cipher(message, keys)
    alphabet = ('a'..'z').to_a

    new_mess = message.split('').map.with_index do |char, i|
        old_idx = alphabet.index(char)
        new_idx = (old_idx + keys[i % keys.length]) % alphabet.length
        alphabet[new_idx]
    end

    new_mess.join('')
end

# Examples
p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
p vigenere_cipher("yawn", [5, 1])             # => "dbbo"
puts "----------"


# vowel_rotate
# Write a method vowel_rotate(str) that accepts a string as an arg and returns the string where every vowel is replaced 
# with the vowel the appears before it sequentially in the original string. The first vowel of the string should be replaced with the last vowel.

def vowel_rotate(str)
    vowels = []
    str.each_char { |char| vowels << char if 'aeiou'.include?(char) }
    vowels = vowels.rotate(-1)

    new_word = str.split('').map do |char|
        if 'aeiou'.include?(char)
            vowels.shift
        else
            char
        end
    end

    new_word.join('')
end

# Examples
p vowel_rotate('computer')      # => "cempotur"
p vowel_rotate('oranges')       # => "erongas"
p vowel_rotate('headphones')    # => "heedphanos"
p vowel_rotate('bootcamp')      # => "baotcomp"
p vowel_rotate('awesome')       # => "ewasemo"
puts "----------"


# PROC PROBLEMS
# String#select
# Extend the string class by defining a String#select method that accepts a block. The method should return a new string containing characters of the 
# original string that return true when passed into the block. If no block is passed, then return the empty string. Do not use the built-in Array#select 
# in your solution.

class String
    def select(&prc)
        return '' if prc.nil?
        new_str = ''
        self.each_char { |char| new_str += char if prc[char] }
        new_str
    end

    def map!(&prc)
        self.each_char.with_index { |char, i| self[i] = prc[char, i] }
    end
end

# Examples
p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
p "HELLOworld".select          # => ""
puts "----------"


# String#map!
# Extend the string class by defining a String#map! method that accepts a block. The method should modify the existing string by 
# replacing every character with the result of calling the block, passing in the original character and it's index. Do not use the 
# built-in Array#map or Array#map! in your solution.


# Examples
word_1 = "Lovelace"
word_1.map! do |ch| 
    if ch == 'e'
        '3'
    elsif ch == 'a'
        '4'
    else
        ch
    end
end
p word_1        # => "Lov3l4c3"

word_2 = "Dijkstra"
word_2.map! do |ch, i|
    if i.even?
        ch.upcase
    else
        ch.downcase
    end
end
p word_2        # => "DiJkStRa"
puts "----------"


#RECURSION PROBLEMS
# multiply
# Write a method multiply(a, b) that takes in two numbers and returns their product.
# You must solve this recursively (no loops!)
# You must NOT use the multiplication (*) operator

def multiply(a, b)
    return 0 if b == 0
    return -multiply(a, -b) if b < 0
    a + multiply(a, b - 1)
end

# Examples
p multiply(3, 5)        # => 15
p multiply(5, 3)        # => 15
p multiply(2, 4)        # => 8
p multiply(0, 10)       # => 0
p multiply(-3, -6)      # => 18
p multiply(3, -6)       # => -18
p multiply(-3, 6)       # => -18
puts "----------"


# lucas_sequence
# The Lucas Sequence is a sequence of numbers. The first number of the sequence is 2. The second number of the Lucas Sequence is 1. 
# To generate the next number of the sequence, we add up the previous two numbers. For example, the first six numbers of the sequence are: 
# 2, 1, 3, 4, 7, 11, ...
# Write a method lucasSequence that accepts a number representing a length as an arg. The method should return an array containing the Lucas 
# Sequence up to the given length. Solve this recursively.

def lucasSequence(num)
    return [] if num == 0
    return [2] if num == 1
    return [2, 1] if num == 2

    seq = lucasSequence(num - 1)
    seq << seq[-1] + seq[-2]
end

# Examples
p lucasSequence(0)   # => []
p lucasSequence(1)   # => [2]    
p lucasSequence(2)   # => [2, 1]
p lucasSequence(3)   # => [2, 1, 3]
p lucasSequence(6)   # => [2, 1, 3, 4, 7, 11]
p lucasSequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]
puts "----------"


# prime_factorization
# The Fundamental Theorem of Arithmetic states that every positive integer is either a prime or can be represented as a product of prime numbers.
# Write a method prime_factorization(num) that accepts a number and returns an array representing the prime factorization of the given number. 
# This means that the array should contain only prime numbers that multiply together to the given num. The array returned should contain numbers 
# in ascending order. Do this recursively.

def prime_factorization(num)
    (2...num).each do |n|
        if num % n == 0
            return [*prime_factorization(n), *prime_factorization(num / n)]
        end
    end

    [num]   #base case, return if num is prime 
end

# Examples
p prime_factorization(12)     # => [2, 2, 3]
p prime_factorization(24)     # => [2, 2, 2, 3]
p prime_factorization(25)     # => [5, 5]
p prime_factorization(60)     # => [2, 2, 3, 5]
p prime_factorization(7)      # => [7]
p prime_factorization(11)     # => [11]
p prime_factorization(2017)   # => [2017]
puts "----------"


# def no_dupes?(arr)
    # hash = Hash.new(0)
    # arr.each { |el| hash[el] += 1 }
    # hash.keys.select { |key| hash[key] == 1 }
# end


# def no_consecutive_repeats?(arr)
    # (0...arr.length - 1).none? { |i| arr[i] == arr[i+1] }
# end


# def char_indices(str)
    # hash = Hash.new { |h, k| h[k] = [] }
    # str.each_char.with_index { |char, i| hash[char] << i }
    # hash
# end



# def longest_streak(str)
#     hash = {}
    
#     i = 0
#     while i < str.length
#         count = 1

#         while str[i] == str[i+1]
#             count += 1
#             i += 1
#         end

#         hash[str[i]] = count
#         i += 1
#     end

#     sort = hash.sort_by { |k, v| v }
#     sort.last[0] * sort.last[1]
# end




# def bi_prime?(num)
#     prime = []
#     (2...num).each { |i| prime << i if prime?(i) }
#     (0...prime.length).each do |i|
#         (i...prime.length).each do |j|
#             return true if prime[i] * prime[j] == num
#         end
#     end 
    
#     false
# end

# def prime?(num)
#     (2...num).none? { |i| num % i == 0 }
# end

# def vigenere_cipher(message, keys)
#     encrypted = ''

#     alphabet = ('a'..'z').to_a 
#     message.each_char.with_index do |char, i| 
#             old_idx = alphabet.index(char)
#             new_idx = (old_idx + keys[i % keys.length]) % alphabet.length
#             encrypted += alphabet[new_idx]
#     end

#     encrypted
# end


# def vowel_rotate(str)
#     vowels = str.split('').select { |char| 'aeiou'.include?(char) }
#     vowels = vowels.rotate(-1)

#     answer = str.split('').map do |char|
#         if 'aeiou'.include?(char)
#             vowels.shift
#         else
#             char
#         end
#     end

#     answer.join('')
# end


# class String
#     def select(&prc)
#         str = ''
#         return str if prc.nil?
#         self.each_char { |char| str += char if prc[char] }
#         str
#     end

#     def map!(&prc)
#         self.each_char.with_index { |char, i| self[i] = prc[char, i] }
#     end
# end


# def multiply(a, b)
#     return 0 if b == 0
#     return -multiply(a,-b) if b < 0
#     a + multiply(a, b - 1)
# end

# multiply(-3, -2)
#     - multiply(3, 2)
#         -3 + multiply(3, 1)
#             -3 + multiply(3, 0)
#                 0

# multiply(3, -2)
#     - multiply(3, 2)
#         3 + multiply(3, 1)
#             3 + multiply(3, 0)
#                 0

# multiply(3, 2)
#     3 + multiply(3, 1)
#         3 + multiply(3, 0)
#             0


# def lucasSequence(num)
#     return [] if num == 0
#     return [2] if num == 1
#     return [2, 1] if num == 2

#     seq = lucasSequence(num - 1)
#     seq << seq[-2] + seq[-1]
# end

# lucasSequence(3)
#     seq = lucasSequence(2)
#         [2, 1]
#             << seq[-2] + seq[-1]
#                 3

# lucasSequence(6)   
#     seq = lucasSequence(5)
#         seq = lucasSequence(4)
#             seq = lucasSequence(3)
#                 seq = lucasSequence(2) 
#                     [2,1] << seq[-2] + seq[-1]

# def prime_factorization(num)
#     (2...num).each do |i|
#         if num % i == 0
#             return [*prime_factorization(i), *prime_factorization(num/i)]
#         end
#     end

#     [num]
# end

# prime_factorization(2017)
#     [2017]

# prime_factorization(12) 
#     [ *prime_factorization(2),                  *prime_factorization(6)                                     ]
#     [ *[2],                                     [*prime_factorization(2), *prime_factorization(3)]          ]
#     [   2,                                      [ *[2],                   *[3]                   ]          ]