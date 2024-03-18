# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.





















def largest_prime_factor(num)
    num.downto(2) { |div| return div if num % div == 0 && prime?(div)  }
end

def prime?(num)
    (2...num).none? { |n| num % n == 0 }
end

def unique_chars?(str)
    hash = Hash.new(0)
    str.each_char { |char| hash[char] += 1 }
    hash.each_value { |v| return false if v > 1 }
    true
end

def dupe_indices(arr)
    hash = Hash.new {|k,v| k[v] = [] }
    arr.each_with_index { |ele, i| hash[ele] << i  }
    hash.select { |k, v_arr| v_arr.length > 1  }
end

def ana_array(arr1, arr2)
    letters(arr1) == letters(arr2)
end

def letters(arr)
    hash = Hash.new(0)
    arr.each { |ele| hash[ele] += 1 }
    hash
end
