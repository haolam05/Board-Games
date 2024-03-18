def average(num1, num2)
    (num1 + num2) / 2.0
end

def average_array(arr)
    arr.sum / arr.length.to_f       # OR arr.sum / (arr.length * 1.0)
end

def repeat(str, num)
    str * num
end

def yell(str)
    str.upcase + '!'
end

# def alternating_case(sentence)
#     str = sentence.split                
#     str.each_with_index do |word, i|    
#         if i.even?                                             
#             str[i] = str[i].upcase
#         else
#             str[i] = str[i].downcase
#         end
#     end
#     str.join(' ')
# end

def alternating_case(sentence)
    new_sentence = sentence.split.map.with_index do |word, i|
        if i.even?
            word.upcase
        else
            word.downcase
        end
    end
    new_sentence.join(' ')
end