require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :max, :prc, :map, :store

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    @map[key] ? update_node!(@map[key]) : calc!(key)
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

private
  def calc!(key)
    val = prc.call(key)
    @map[key] = @store.append(key, val)
    eject! if count > max     
    val #the count > max only after node is added, so need to check here instead of checking at the beginning of method
  end   

  def update_node!(node)
    @map[node.key] = @store.append(node.remove.key, node.val)
    node.val
  end                              #access again, readded => el becomes most recently

  def eject!
    @map.delete(@store.first.remove.key)
  end
end
