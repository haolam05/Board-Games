def palindrome?(str)
    copy = ''
    (0..str.length - 1).reverse_each { |i| copy += str[i] }
    copy == str
end


def substrings(str)
    arr = []

    i = 0                   # 0   01  012 0123
    while i < str.length    # 1   12  123
        copy = str[i]       # 2   23
        arr << copy         # 3
        (i+1...str.length).each { |i| arr << (copy += str[i]) }
        i += 1
    end
    
    arr
end

# def substrings(str)
#     arr = []

#     (0...str.length).each do |idx_first|
#         (idx_first...str.length).each do |idx_last|
#             arr << str[idx_first..idx_last]
#         end
#     end
#     arr
# end

def palindrome_substrings(str)
    substrings(str).select { |substring| substring.length > 1 && palindrome?(substring) }
end