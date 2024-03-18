def select_even_nums(arr)
    arr.select(& :even?)
end

def reject_puppies(arr)
    arr.reject { |hash_dog| hash_dog['age'] <= 2 }
end

def count_positive_subarrays(arr_2D)
    arr_2D.count { |subArr| subArr.sum > 0 }
end

def aba_translate(word)
    str = ''
    word.each_char do |char|
        if 'aeiou'.include?(char)
            str += char + 'b'
        end
            str += char
    end
    str
end

def aba_array(arr)
    arr.map { |word| aba_translate(word) }
end
