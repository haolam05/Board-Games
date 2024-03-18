class MaxIntSet
  attr_reader :store

  def initialize(max)
    @store = Array.new(max + 1, false)
  end

  def insert(num)
    check_range(num)
    @store[num] = true
  end

  def remove(num)
    check_range(num)
    @store[num] = false 
  end

  def include?(num)
    check_range(num)
    @store[num]
  end

private
  def in_range?(num)
    num.between?(0, max)
  end

  def max
    @store.length - 1
  end

  def check_range(num)
    raise "Out of bounds" if !in_range?(num)
  end
end

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    add(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

private
  def [](num)
    @store[bucket_location(num)]
  end

  def add(num)
    @store[bucket_location(num)] << num
  end

  def num_buckets
    @store.length
  end

  def bucket_location(num)
    num % num_buckets
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !include?(num)
      resize! if count == num_buckets
      add(num)
      @count += 1
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num) 
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

private
  def [](num)
    @store[bucket_location(num)]
  end

  def num_buckets
    @store.length
  end

  def bucket_location(num)
    num % num_buckets
  end
  
  def add(num)
    @store[bucket_location(num)] << num
  end

  def resize!
    new_num_buckets = num_buckets * 2
    new_store = Array.new(new_num_buckets) { Array.new }
    @store.flatten.each { |num| new_store[num % new_num_buckets] << num }
    @store = new_store
  end
end


# given array in parameter : []

#                 n           hash1

# [1]             0 pairs
# [1,2]           1 pairs     hash2
# [1,2,3]         3 pairs
# [1,2,3,4]       6 pairs       
# [1,2,3,4,5]     10 pairs
# [1,2,3,4,5,6]   14 pairs
# [1,2,3,4,5,7,8] 20 pairs

                           
# [1]             0 pairs
# [1,2]           0 pairs
# [1,2,3]         1 pairs
# [1,2,3,4]       3 pairs     hash3 
# [1,2,3,4,5]     6 pairs
# [1,2,3,4,5,6]   10 pairs
# [1,2,3,4,5,6,7] 16 pairs


# hash1 []  n
# hash2 []  2n
# hash3 []  2,2 n


# when input has size 4, then space is 3n + 1 = 13      n^2 = 16
# when input has size 5, then space is 4n + 1 = 21      n^2 = 25
# when input has size 6, then space is 5n + 0 = 30      n^2 = 36
# when input has size 7, then space is 6n + 1 = 43      n^2 = 49


#   hash1     n  
#   hash2     hash1.length + ...
#   hash3     hash2.length + ...