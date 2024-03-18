






















# def zip(*arrs)
#     arr_2D = Array.new(arrs.first.length) { [] }

#     (0...arrs.first.length).each do |i|
#         arrs.each { |subArr| arr_2D[i] << subArr[i] }
#     end

#     arr_2D
# end

# def prizz_proc(arr, prc1, prc2)
#     arr.select { |el| (prc1[el] || prc2[el]) && !(prc1[el] && prc2[el]) }
# end

# def zany_zip(*arrs)
#     lengths = []
#     arrs.each { |arr| lengths << arr.length }
#     arr_2D = Array.new(lengths.max) { [] }

#     (0...lengths.max).each do |i|
#         arrs.each { |subArr| arr_2D[i] << subArr[i] }
#     end

#     arr_2D
# end

# def maximum(arr, &blk)
#     trues = arr.select { |el| blk[el] }
#     trues.each { |el| return el if el.is_a?(Integer) && el.abs > trues.max }    # takes care of the negative case(integer) (4, -5)
#     trues.reverse.max   # return the el that appears later in the arr in case of a tie
# end

# def my_group_by(arr, &blk)
#     hash = Hash.new { |h, k| h[k] = [] }
#     arr.each { |el| hash[blk[el]] << el }
#     hash
# end 

# def max_tie_breaker(arr, prc, &blk)
#     max = arr.first
#     arr.each { |el| max = el if (blk[el] > blk[max]) || (blk[el] == blk[max] && prc[el] > prc[max]) }
#     max
# end

# def silly_syllables(sent)
#     new_sent = sent.split.map do |word|  
#         if count_vowels(word) >= 2 
#             remove_vowels(word)
#         else
#             word
#         end
#     end

#     new_sent.join(' ')
# end

# def remove_vowels(word)
#     idx = []
#     word.split('').each_with_index { |char, i| idx << i if 'aeiou'.include?(char) }
#     word[idx[0]..idx[-1]]
# end

# def count_vowels(word)
#     word.split('').count { |char| 'aeiou'.include?(char) }
# end

# def silly_syllables(sentence)
#     new_sentence = sentence.split(' ').map do |word|
#         vowels = []
#         word.each_char.with_index { |char, i| vowels << i if 'aeiou'.include?(char) }

#         if vowels.length < 2
#             word
#         else
#             word[vowels[0]..vowels[-1]]
#         end
#     end

#     new_sentence.join(' ')
# end