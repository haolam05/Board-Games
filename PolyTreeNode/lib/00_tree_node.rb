module Searchable                                           #               1
                                                            #        2      3      4
    def dfs(target)                                         #      4   5    6      7
        return self if self.nil? || self.value == target
        children.each do |child| 
            result = child.dfs(target) 
            return result if !result.nil?
        end
        nil
    end

    def bfs(target)
        queue = [self]
        until queue.empty?
            parent = queue.shift
            return parent if parent.value == target
            parent.children.each { |child| queue << child }
        end
    end
end

####parent=()
#if self's parent is RE-assgined for self(it already has a parent now), self current parent should remove self from the children list of current parent
#then set new_parent for self
#then add self into the children list of self's new_parent
#   + make sure that there is only ONE self in the children list of self's new parent
#   + if new parent is nil, do not add self to the children list of self's new parent

class PolyTreeNode

    include Searchable
    attr_reader :value, :parent, :children

    def initialize(value)
        @value, @parent, @children = value, nil, []
    end
            
    def parent=(new_parent) 
        parent.children.delete(self) if parent != new_parent && !parent.nil?
        @parent = new_parent
        new_parent.children << self if !new_parent.nil? && !new_parent.children.include?(self)
    end
                                
    def add_child(child)
        child.parent = self
    end

    def remove_child(child)
        children.include?(child) ? child.parent = nil : raise
    end        
end

tree = PolyTreeNode.new('root')
child = PolyTreeNode.new('a')
p tree.add_child(child)
p tree.remove_child(child)




























# module Searchable                                           #               1
#                                                             #        2      3      4
#     def dfs(target)                                         #      4   5    6      7
#         return self if self.nil? || self.value == target    #     8 9     10 11       
#         children.each do |child|                            #   12
#             result = child.dfs(target)
#             return result if !result.nil? 
#         end
#         nil
#     end

#     def bfs(target)
#         queue = [self]
#         until queue.empty?
#             parent = queue.shift
#             return parent if parent.value == target
#             parent.children.each { |child| queue.push(child) }
#         end
#     end
# end

# ####parent=()
# #if self's parent is RE-assgined for self(it already has a parent now), self current parent should remove self from the children list of current parent
# #then set new_parent for self
# #add self into the children list of self's new_parent
# #   + make sure that there is only ONE self in the children list of self's new parent
# #   + if new parent is nil, do not add self to the children list of self's new parent

# class PolyTreeNode

#     include Searchable
#     attr_reader :value, :parent, :children

#     def initialize(value)
#         @value, @parent, @children = value, nil, []
#     end

#     def parent=(new_parent) 
#         @parent.children.delete(self) if !parent.nil? && parent != new_parent
#         @parent = new_parent
#         new_parent.children << self if !new_parent.nil? && !new_parent.children.include?(self)
#     end

#     def add_child(child)
#         child.parent = self
#     end

#     def remove_child(child)
#         children.include?(child) ? child.parent = nil : raise 
#     end
# end



#2        RANDOM PolyTreeNode     node1               node9
            #self                 (new_parent)        (current parent)
# value:    1                                           
# parent:   2 node1                                     
# children: 3                       children = [node2]  children = []
