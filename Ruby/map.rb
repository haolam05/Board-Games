require 'byebug'
class Map
    def initialize
        @map = []
    end

    def keys
        @map.flatten.select.with_index { |k, i| i.even? }
    end
    
    def key_idx(k)
        @map.each_with_index { |subArr, i| return i if subArr.first == k }
    end
    
    def set(k, v)
        keys.include?(k) ? @map[key_idx(k)] = [k, v] : @map << [k, v]
    end

    def get(k)
        keys.include?(k) ? "value of this key is: #{@map[key_idx(k)].last}" : "key does not exist."
    end

    def delete(k)
        @map.select! { |(key, v)| k != key  }
    end

    def show
        deep_dup(@map)
    end

    private
    def deep_dup(arr)
        arr.map { |el| el.is_a?(Array) ? deep_dup(el) : el }
    end
end

m = Map.new
p m.show
m.set('a', 1)
m.set('b', 2)
m.set('c', 3)
m.set('d', 4)
p m.show
m.set('d', 5)
m.delete('a')
p m.show
m.delete('d')
p m.get('d')
p m.get('a')
p m.get('c')
p m.show