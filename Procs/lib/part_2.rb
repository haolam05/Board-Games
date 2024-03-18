




















# def reverser(str, &prc)
#     prc[str.reverse]
# end

# def word_changer(sentence, &prc)
#     sentence.split.map { |ele| prc[ele] }.join(' ')
# end

# def greater_proc_value(num, prc1, prc2)
#     return prc1[num] if prc1[num] > prc2[num]
#     prc2[num]
# end

# def and_selector(arr, prc1, prc2)
#     arr.select { |ele| prc1[ele] && prc2[ele] }
# end

# def alternating_mapper(arr, prc1, prc2)
#     arr.map.with_index do |ele, i|
#         if i.even?
#             prc1[ele]
#         else
#             prc2[ele]
#         end
#     end
# end