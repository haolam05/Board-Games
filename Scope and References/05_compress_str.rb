# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".










p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"

def compress_str(str)
    new_str = ''

    i = 0
    while i < str.length
        count = 1

        while str[i] == str[i+1]
            count += 1
            i += 1
        end

        if count == 1
            new_str += str[i]
        else
            new_str += count.to_s + str[i]
        end

        i += 1
    end

    new_str
end
