# Write a method, all_vowel_pairs, that takes in an array of words and returns all pairs of words
# that contain every vowel. Vowels are the letters a, e, i, o, u. A pair should have its two words
# in the same order as the original array.

def all_vowel_pairs(words)
    pairs = []

    (0...words.length).each do |i|
        (i+1...words.length).each do |j|
            word = words[i] + ' ' + words[j]
            pairs << word if 'aeiou'.split('').all? { |vowel| word.include?(vowel) }
        end
    end

    pairs
end


def composite?(num)
    (2...num).any? { |div| num % div == 0 }
end


def find_bigrams(str, bigrams)
    bigrams.select { |bigram| bigram if str.include?(bigram) }
end


class Hash
    def my_select(&prc)
        prc ||= Proc.new { |k, v| k == v }
        self.select { |k, v| prc[k, v] }
    end
end



class String
    def substrings(length = nil)
        substring = []

        (0...self.length).each do |starting|
            (starting...self.length).each { |ending| substring << self[starting..ending] }
        end

        return substring if length.nil?
        substring.select { |sub| sub.length == length }
    end

        def caesar_cipher(num)
        str = ''

        alphabet = ('a'..'z').to_a
        self.each_char do|char|
            old_idx = alphabet.index(char)
            new_idx = (old_idx + num) % alphabet.length
            str += alphabet[new_idx]
        end

        str
    end
end
