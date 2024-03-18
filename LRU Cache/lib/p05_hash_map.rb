require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)    
    if !include?(key)
      resize! if @count >= num_buckets
      @store[bucket(key)].append(key, val)
      @count += 1
    else
      @store[bucket(key)].update(key, val)
    end
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    if include?(key) 
      @store[bucket(key)].remove(key)
      @count -= 1
    end
  end

  def each
    @store.each { |link| link.each { |node| yield [node.key, node.val] } }
  end

  def to_s
    pairs = inject([]) { |strs, (k, v)| strs << "#{k.to_s} => #{v.to_s}" }
    "{ " + pairs.join(",\n") + " }"
  end

  alias_method :inspect, :to_s
  alias_method :[], :get
  alias_method :[]=, :set

private
  def num_buckets
    @store.length
  end

  def resize!
    new_num_buckets = num_buckets * 2
    new_store = Array.new(new_num_buckets) { LinkedList.new }
    each { |k, v| new_store[k.hash % new_num_buckets].append(k, v) }
    @store = new_store
  end

  def bucket(key)
    key.hash % num_buckets
  end
end

