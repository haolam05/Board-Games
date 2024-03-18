def hipsterfy(word)
    (0...word.length).reverse_each do |i|
        if 'aeiou'.include?(word[i])
            return word[0...i] + word[i+1..-1]
        end
    end
    word
end

def vowel_counts(str)
    hash = Hash.new(0)

    str.downcase.each_char do |char|
        if 'aeiou'.include?(char)
            hash[char] += 1
        end
    end

    hash
end

def caesar_cipher(word, num)
    alphabet = ('a'..'z').to_a
    new_str = ''

    word.each_char do |char|
        if alphabet.include?(char)
            old_idx = alphabet.index(char)
            new_idx = (old_idx + num) % alphabet.length
            new_str += alphabet[new_idx]
        else
            new_str += char
        end
    end

    new_str
end
















# def hipsterfy(word)
#     (0..word.length - 1).reverse_each do |i|
#         if 'aeiou'.include?(word[i])
#             return word[0...i] + word[i+1..-1]
#         end
#     end
#     word
# end

# def vowel_counts(str)
#     hash = Hash.new(0)
#     str.each_char do |char|
#         copy = char.downcase
#         if 'aeiou'.include?(copy)
#             hash[copy] += 1
#         end
#     end
#     hash
# end

# def caesar_cipher(str, n)
#     new_str = ''
#     alphabet = 'abcdefghijklmnopqrstuvwxyz'
#     str.each_char do |char|
#         if alphabet.include?(char)
#             old_idx = alphabet.index(char)
#             new_idx = (old_idx + n) % alphabet.length
#             new_str += alphabet[new_idx]
#         else
#             new_str += char
#         end
#     end
#     new_str
# end