n = 5000
puts "Here are the result of average run-time of #{n} runs:"

#PART I
# Big O-ctopus and Biggest Fish
# A Very Hungry Octopus wants to eat the longest fish in an array of fish.
# ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
# => "fiiiissshhhhhh"

# 1) Sluggish Octopus
# Find the longest fish in O(n^2) time. Do this by comparing all fish lengths to all other fish lengths

def sluggish(fishes)
    fishes.each do |fish| 
        longest = true
        fishes.each { |other_fish| longest = false if other_fish.length > fish.length }
        return fish if longest
    end
end                            


# def sluggish(fishes)
#     fishes.each { |fish1| return fish1 if fishes.none? { |fish2| fish2.length > fish1.length } }
# end

puts "This is:  O(n^2)      -   #bubble_sort    -   nested_loop"
times = []
n.times do 
    t = Time.now
    sluggish(['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh'])
    times << Time.now - t
end
p times.sum
p sluggish(['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh'])
puts "\n"


# 2) Dominant Octopus
# Find the longest fish in O(n log n) time. Hint: You saw a sorting algorithm that runs in O(n log n) 
# in the Sorting Complexity Demo. Remember that Big O is classified by the dominant term.
def dominant(fishes)
    merge_sort(fishes).last
end

def merge_sort(arr)
    return arr if arr.length < 2
    mid = arr.length / 2
    merge(merge_sort(arr.take(mid)), merge_sort(arr.drop(mid)))
end

def merge(left, right)
    merged = []
    merged << (right.first.length > left.first.length ? left.shift : right.shift) until left.empty? || right.empty?
    merged + left + right
end

puts "This is:  O(nlogn)   -   #merge_sort"
times = []
n.times do 
    t = Time.now
    dominant(['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh'])
    times << Time.now - t
end
p times.sum
p dominant(['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh'])
puts "\n"


# 3) Clever Octopus
# Find the longest fish in O(n) time. The octopus can hold on to the longest fish that you have found so far 
# while stepping through the array only once.
def clever(fishes)
    longest = fishes.first
    (1...fishes.length).each { |i| longest = fishes[i] if fishes[i].length > longest.length }
    longest
end

puts "This is:  O(n)       -       #iterate_one_time_through_whole_array"
times = []
n.times do 
    t = Time.now
    clever(['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']) 
    times << Time.now - t
end
p times.sum
p clever(['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh'])
puts "\n"


# PART II
# Dancing Octopus
# Full of fish, the Octopus attempts Dance Dance Revolution. The game has tiles in the following directions:
# tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
# To play the game, the octopus must step on a tile with her corresponding tentacle. 
# We can assume that the octopus eight tentacles are numbered and correspond to the tile direction indices.

# 1) Slow Dance
# Given a tile direction, iterate through a tiles array to return the tentacle number (tile index) the octopus must move. 
# This should take O(n) time.
def slow_dance(move_dir, tiles)
    tiles.each_index { |i| return i if tiles[i] == move_dir }
end

puts "This is:  O(n)       -       #iterate_one_time_through_whole_array"
tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
times = []
n.times do 
    t = Time.now
    slow_dance("up", tiles_array) 
    slow_dance("right_down", tiles_array) 
    times << Time.now - t
end
p times.sum
p slow_dance("up", tiles_array)           #0
p slow_dance("right-down", tiles_array)   #3
puts "\n"


# 2) Constant Dance!
# Now that the octopus is warmed up, let help her dance faster. Use a different data structure and 
# write a new function so that you can access the tentacle number in O(1) time.
def fast_dance(move_dir, tiles)
    tiles.index(move_dir)       #O(n), iterate through array to find element then return index
end

def fast_dance2(move_dir, tiles)
    {                           #O(1), hashmap has no order, key is unique therefore lookup is O(1)
    "up" => 0,
    "right-up" => 1,
    "right"=> 2,
    "right-down" => 3,
    "down" => 4,
    "left-down" => 5,
    "left" => 6,
    "left-up" => 7
    }[move_dir]
end
puts "This is:  O(1)    -       #immediate access   -   algorithm runtime is independent of array size"
tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
times = []
n.times do 
    t = Time.now
    fast_dance("up", tiles_array) 
    fast_dance("right_down", tiles_array) 
    times << Time.now - t
end
p times.sum
p fast_dance("up", tiles_array)           #0
p fast_dance("right-down", tiles_array)   #3
puts "\n"