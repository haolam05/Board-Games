class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

private
  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_accessor :count, :store

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i < 0 ? (i.abs > count) : i >= count
    i < 0 ? store[count+i] : store[i]
  end

  def []=(i, val)
    if i >= count #a=[2,3], a[3]=4 => a=[2,3,nil,4]
        (i-count).times { push(nil) } 
        @count += 1
        resize! if count >= capacity
    elsif i < 0
      return nil if i.abs > count #store=[2,3] store[-3]=1 => impossible
      return self[count+i] = val
    end

    @store[i] = val
  end

  def capacity
    store.length
  end

  def include?(val)
    any? { |el| el == val }
  end

  def push(val)
    resize! if count >= capacity
    @store[count] = val
    @count += 1
  end

  def unshift(val)
    @count += 1
    resize! if count >= capacity
    (1...capacity).reverse_each { |i| @store[i] = @store[i-1] }
    @store[0] = val
  end

  def pop
    return nil if count == 0
    pop_item = store[count - 1]
    @store[count - 1] = nil 
    @count -= 1
    pop_item
  end

  def shift
    return nil if count == 0
    shifted_item = first
    (0...capacity - 1).each { |i| @store[i] = store[i+1] }
    @store[count - 1] = nil 
    @count -= 1
    shifted_item
  end

  def first
    store[0]
  end

  def last
    store[count - 1]
  end

  def each
    count.times { |i| yield self[i] }
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    length == other.length && (0...capacity).all? { |i| self[i] == other[i] }
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

private
  def resize!
    arr = StaticArray.new(capacity * 2)
    each_with_index { |el, i| arr[i] = el } #store=[1,nil,nil,2]
    @store = arr                            #each =[1,2]
  end 
end


# class StaticArray
#   attr_reader :store

#   def initialize(capacity)
#     @store = Array.new(capacity)
#   end

#   def [](i)
#     validate!(i)
#     self.store[i]
#   end

#   def []=(i, val)
#     validate!(i)
#     self.store[i] = val
#   end

#   def length
#     self.store.length
#   end

# private
#   def validate!(i)
#     raise "Overflow error" unless i.between?(0, self.store.length - 1)
#   end
# end

# class DynamicArray
#   include Enumerable
#   attr_accessor :count, :store, :start_idx

#   def initialize(capacity = 8)
#     @store = StaticArray.new(capacity)
#     @count = 0
#     @start_idx = 0
#   end

#   def [](i)
#     return nil if i < 0 ? (i.abs > count) : i >= count
#     i < 0 ? store[(start_idx + count + i) % capacity] : store[(start_idx + i) % capacity] 
#   end

#   def []=(i, val)
#     if i >= count #a=[2,3], a[3]=4 => a=[2,3,nil,4]
#         (i-count).times { push(nil) } 
#         @count += 1
#         resize! if count >= capacity
#     elsif i < 0
#       return nil if i.abs > count #store=[2,3] store[-3]=1 => impossible
#       return self[count+i] = val
#     end

#     @store[(start_idx + i) % capacity] = val
#   end

#   def capacity
#     store.length
#   end

#   def include?(val)
#     any? { |el| el == val }
#   end

#   def push(val)
#     resize! if count >= capacity
#     @store[(start_idx + count) % capacity] = val
#     @count += 1
#   end

#   def unshift(val)
#     @count += 1
#     resize! if count >= capacity
#     @start_idx = start_idx - 1
#     @store[start_idx % capacity] = val
#   end

#   def pop
#     return nil if count == 0
#     pop_item = store[count - 1]
#     @store[count - 1] = nil 
#     @count -= 1
#     pop_item
#   end

#   def shift
#     return nil if count == 0
#     @count -= 1
#     shifted_item = first
#     @start_idx = start_idx + 1
#     shifted_item
#   end

#   def first
#     store[start_idx]
#   end

#   def last
#     store[(start_idx + count - 1) % capacity]
#   end

#   def each
#     count.times { |i| yield self[i] }
#   end

#   def to_s
#     "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
#   end

#   def ==(other)
#     return false unless [Array, DynamicArray].include?(other.class)
#     length == other.length && (0...capacity).all? { |i| self[i] == other[i] }
#   end

#   alias_method :<<, :push
#   [:length, :size].each { |method| alias_method method, :count }

# private
#   def resize!
#     arr = StaticArray.new(capacity * 2)
#     each_with_index { |el, i| arr[i] = el } #store=[1,nil,nil,2]
#     @store = arr                            #each =[1,2]
#     @start_idx = 0
#   end 
# end

