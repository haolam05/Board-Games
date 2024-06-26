  class LRUCache
    def initialize(size)
        @size = size
        @cash = []
    end

    def count
        @cash.count
    end

    def add(el)
        remove_duplicate(el)
        @cash.shift if count >= @size
        @cash << el
    end

    def show
        p @cash
    end

private
    def remove_duplicate(el)
        @cash.delete(el) if @cash.include?(el)
    end
    
  end

  johnny_cache = LRUCache.new(4)
  johnny_cache.add("I walk the line")
  johnny_cache.add(5)
p johnny_cache.count                        
  # => returns 2
  johnny_cache.add([1,2,3])
  johnny_cache.add(5)
  johnny_cache.add(-5)
  johnny_cache.add({a: 1, b: 2, c: 3})
  johnny_cache.add([1,2,3,4])
  johnny_cache.add("I walk the line")
  johnny_cache.add(:ring_of_fire)
  johnny_cache.add("I walk the line")
  johnny_cache.add({a: 1, b: 2, c: 3})
  johnny_cache.show                         
  # => prints [[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]