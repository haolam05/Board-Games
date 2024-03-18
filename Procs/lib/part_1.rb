def my_map(arr, &prc)
    new_arr = []
    arr.each { |ele| new_arr << prc[ele] }
    new_arr
end

def my_select(arr, &prc)
    new_arr = []
    arr.each { |ele| new_arr << ele if prc[ele] }
    new_arr
end

def my_count(arr,&prc)
    count = 0
    arr.each { |ele| count += 1 if prc[ele] }
    count
end

def my_any?(arr, &prc)
    arr.each { |ele| return true if prc[ele] }
    false
end

def my_all?(arr, &prc)
    arr.each { |ele| return false  if !prc[ele] }
    true
end

def my_none?(arr, &prc)
    arr.each { |ele| return false if prc[ele] }
    true
end



















def my_map(arr, &block)
    arr.map(&block)
end

def my_map(arr, &block)
    new_arr = []
    arr.each { |ele| new_arr << block.call(ele) }
    new_arr
end

def my_select(arr, &block)
    new_arr = []
    arr.each {|ele| new_arr << ele if block.call(ele) }
    new_arr
end

def my_count(arr, &block)
    count = 0
    arr.each { |ele| count += 1 if block.call(ele) }
    count
end

def my_any?(arr, &block)
    arr.each { |ele| return true if block.call(ele) }
    false
end

def my_all?(arr, &block)
    arr.each { |ele| return false if !block.call(ele) }
    true
end

def my_none?(arr, &block)
    arr.each { |ele| return false if block.call(ele) }
    true
end
