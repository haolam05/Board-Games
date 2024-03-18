def proper_factors(n)
    (1...n).select { |i| n % i == 0 }
end

def aliquot_sum(n)
    proper_factors(n).sum
end

def perfect_number?(n)
    return false if aliquot_sum(n) != n
    true
end

def ideal_numbers(n)
    ideal_nums = []
    num = 5     # smallest perfect number is 6

    while ideal_nums.length != n
        num += 1
        ideal_nums << num if perfect_number?(num)
    end

    ideal_nums
end
