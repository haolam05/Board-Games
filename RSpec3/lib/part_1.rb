def is_prime?(n)
    return false if n < 2
    (2...n).none? { |i| n % i == 0 }
end

def nth_prime(n)
    num = 1
    count_prime = 0

    while count_prime != n
        num += 1
        count_prime += 1 if is_prime?(num)
    end

    num
end

def prime_range(min, max)
    (min..max).select { |num| is_prime?(num) }
end
