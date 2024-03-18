def partition(arr, num)
    new_arr = Array.new(2) { [] }

    arr.each do |n|
        if n <  num
            new_arr[0] << n
        else
            new_arr[1] << n
        end
    end

    new_arr
end

def merge(hash1, hash2)
    hash = {}
    hash1.each { |k, v| hash[k] = v }
    hash2.each { |k, v| hash[k] = v }
    hash
end

def censor(sentence, arr)
    array = sentence.split.map do |word|
        if arr.include?(word.downcase)
            star_vowel(word)
        else
            word
        end
    end

    array.join(' ')
end

def star_vowel(word)
    str = ''

    word.each_char do |char|
        if 'aeiou'.include?(char.downcase)
            str += '*'
        else
            str += char
        end
    end

    str
end

def power_of_two?(num)
    power = 1

    while power < num
        power *= 2
    end

    power == num
end



















# def partition(arr, num)
#     new_arr = Array.new(2) { [] }

#     arr.each do |n|
#         if n < num
#             new_arr[0] << n
#         else
#             new_arr[1] << n
#         end
#     end

#     new_arr
# end

# def merge(hash1, hash2)
#     hash = {}

#     hash1.each do |k, v|
#         if hash2.has_key?(k)
#             hash[k] = hash2[k]
#         else
#             hash[k] = v
#         end
#     end
#     hash2.each { |k,v| hash[k] = v }

#     hash  
# end

# def censor(sentence, arr)
#     array = sentence.split
#     array.each_with_index do |word, i|
#         if arr.include?(word.downcase)
#             array[i] = star_vowel(word)
#         end
#     end

#     array.join(' ')
# end

# def star_vowel(word)
#     str = ''

#     word.each_char.with_index do |char|
#         if 'aeiou'.include?(char.downcase)
#             str += '*'
#         else
#             str += char
#         end
#     end

#     str
# end

# def power_of_two?(num)
#     i = 1
#     while i < num
#         i *= 2
#     end

#     return false if i != num
#     true
# end