class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if !include?(key)
      resize! if count == num_buckets
      add(key)
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key].delete(key) 
      @count -= 1
    end
  end

private
  def [](num)
    @store[bucket_location(num)]
  end

  def num_buckets
    @store.length
  end

  def bucket_location(num)
    num.hash % num_buckets
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
