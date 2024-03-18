require 'byebug'
class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    arr = map.with_index { |n, i| (n.hash + i.hash).to_s(2).to_i }
    hash = arr.first || -1        
    (1...arr.length).each { |i| hash = hash ^ arr[i] }
    hash.hash
  end
end

#The goal is to find a single number that represents the whole array.
#The idea is to make the whole array collaborate together, from index,
#   value, to order of each value because array has order
#A good way to do this is to make each value has some kind of equal 
#   representation. So, we use xor.
#We avoid doing math with (-), (*), (/) to avoid the 0 case => big trouble
#We preserve the order of array by taking index and element into account
#   (element.hash + index.hash): [1,2,3], [2,1,3]
#                 Here, 1.hash + 0.hash != 1.hash + 1.hash 
#                 because number 1 is at different index in each array


class String
  def hash
    chars.map(&:ord).hash
  end
end

class Hash
  def hash #sort from small to big based on hash value of each subArr
    to_a.sort_by(&:hash).hash 
  end #unlike array, hash does not have order, so we need to sort it 
end   #ex: {'a' => 1, 'b' => 2 } == { 'b' => 2, 'a' => 1 }
      #and of course, each time we Hash#hash, we want the same value!
      #hash each value to an integer, then sorted those integer

# [1] pry(main)> a = {'a' => 1, 'c' => 0, 'b' => 2}
# => {"a"=>1, "c"=>0, "b"=>2}
# [2] pry(main)> ["a", 1].hash
# => 3861055482351776985
# [3] pry(main)> ["c", 0].hash
# => -863189020272280314
# [4] pry(main)> ["b", 2].hash
# => 3776611388762301373
# [5] pry(main)> a.map(&:hash)
# => [3861055482351776985, -863189020272280314, 3776611388762301373]
# [6] pry(main)> a.sort_by(&:hash)
# => [["c", 0], ["b", 2], ["a", 1]]
# [7] pry(main)> a.sort_by(&:hash).hash
# => 1241032660662338893



