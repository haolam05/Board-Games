require './item.rb'

class List

    attr_accessor :label

# This method should accept a label as an argument and store the label of the list as an instance variable. 
# Also initialize instance variable called items to an empty array. The array will eventually contain instances of Item.   

    def initialize(label)
        @label = label
        @items = []
    end

# This method should accept a title, deadline, and optional description as arguments. 
# This method should create a new Item with the given information and add it to the end of the items array. 
# When no description is passed in, the new item should have an empty description. 
# If the given deadline is not valid, then no item should be added and the method should return false. 
# If the item is successfully added, then the method should return true. Don't forget to require your 'item.rb' file into 'list.rb'.

    def add_item(title, deadline, description = '')
        return false if !Item.valid_date?(deadline)
        @items << Item.new(title, deadline, description)
        true
    end
    
# This method should return the number of items currently in the list.

    def size
        @items.length
    end

# This method should return a boolean indicating whether or not the given number is a valid position in the list. 
# The first item of the list has index 0, the second item has index 1, and so on. A number is not a valid index if 
# it is negative or too large given the current amount of items in the list.

    def valid_index?(idx)
        0 <= idx && idx <= self.size            #(0...@items.length).include?(idx)
    end

# This method should swap the position of the items at the given indices in the list. 
# If either index is invalid, then don't swap any items and return false. 
# If the indices are valid, then swap the items and return true.

    def swap(idx1, idx2)
        return false if !valid_index?(idx1) || !valid_index?(idx2)
        @items[idx1], @items[idx2] = @items[idx2], @items[idx1]
        true
    end

# This method should return the item of the list that is stored at the given index. 
# If the index is invalid, then return nil. It is important that we define access to 
# items of the list with a custom bracket method and not expose a reader or writer for 
# the instance variable directly (@items). This is to prevent a user from manually manipulating 
# the list in silly ways, like adding non Item instances to the list or having empty entries in the list. 
# We encourage users to only manipulate the list according to the rules and methods that we have defined.

    def [](idx)
        return @items[idx] if valid_index?(idx)
        nil
    end

# This method should return the item at the the top of the list.

    def priority
        @items.first
    end

# This method should print the label of the list and each item's title and deadline. 
# For usability, also print the position of each item in the list. 
# For example, here is a nice way to format the output:
# You don't need to spend too much time making the formatting pretty like we did above. 
# However, if you are interested, we used String#ljust to pad strings with spaces to ensure that
# the columns have equal length. We also used string interpolation to avoid tedious concatenations.

    def print
        puts '-' * 48
        puts ' ' * 20 + self.label.upcase  #groceries.length == 8
        puts '-' * 48
        puts "#{'Index'.ljust(5)} | #{'Item'.ljust(20)} | #{'Deadline'.ljust(10)} | Done"
        puts '-' * 48
        @items.each_with_index { |item, i| puts "#{i.to_s.ljust(5)} | #{item.title.ljust(20)} | #{item.deadline.ljust(10)} | [#{item.done[0]}]" }
    end

# This method should print all information for the item at the given index, including the title, deadline, and description. 
# The method should not print anything if the index not valid.

    def print_full_item(idx)
        puts '-' * 48
        puts "#{@items[idx].title.ljust(30)} #{@items[idx].deadline.ljust(12)} [#{@items[idx].done[0]}]" if self.valid_index?(idx)
        puts @items[idx].description if @items[idx].description != ''
        puts '-' * 48
    end
    
# The method should print all information for the item at the top of the list.

    def print_priority
        print_full_item(0)
    end

# This method should move the item at the given index up the list by continually swapping it with the item directly above it the given amount of times. 
# If the given index is not valid, then it should return false without modifying the list. If the index is valid, then it should return true. 
# When the specified item needs to move up further, but is already at the top of the list, then it should remain at the top. 
# If an amount is not passed in, then move the item up 1 position.
    
    def up(idx, amount = 1)
        return false if !self.valid_index?(idx)

        while amount > 0 && idx != 0
            swap(idx, idx - 1)
            amount -= 1
            idx -= 1
        end

        true
    end

# This method should move the item at the given index down the list by continually swapping it with the item directly below it the given amount of times. 
# If the given index is not valid, then it should return false without modifying the list. If the index is valid, then it should should return true. 
# When the specified item needs to move down further, but is already at the bottom of the list, then it should remain at the bottom. 
# If an amount is not passed in, then move the item down 1 position.

    def down(idx, amount = 1)
        return false if !self.valid_index?(idx)

        while amount > 0 && idx != size - 1
            swap(idx, idx + 1)
            amount -= 1
            idx += 1
        end

        true
    end

# This method should sort the items in the list according to their deadlines. The method should mutate the list's underlying array.
# We can use Ruby's Array#sort_by! to perform this task. In general, the Array#sort_by! method is called on an array and will sort the array in place 
# according to the criteria specified by the block.    

    def sort_by_date!
        @items.sort_by! { |item| item.deadline }
    end


# This new method should "flip" the current state the item instance at given index
    def toggle_item(idx)
        @items[idx].toggle if @items[idx] != nil
    end

# This method should permanently delete the item of the list at the given index. 
# If the index is invalid, the method should return false. If the deletion is successful, then the method should return true. 
# Implement this method so that there are no awkward gaps in the list after an item is removed. 
# Allow a user to utilize this new feature by supporting the input command rm <index>.

    def remove_item(idx)
        return false if !self.valid_index?(idx)
        @items.delete(@items[idx])
        true
    end
  
# This method should remove all items that are currently marked as done. Correctly implementing this may be tricky.

    def purge
        @items = @items.reject { |item| item.done[0] == item.CHECK_MARK }
        # @items.delete_if(&:CHECK_MARK)
    end
end

# list =  List.new('groceries')
# p list
# p list.label
# p list.label = 'a'
# p list.size

# list.add_item('shampoo', '10-24-2019')
# list.add_item('cheese', '2019-10-25', 'Get American and Feta for good measure.')
# list.add_item('toothpaste', '2019-10-25')
# list.add_item('shampoo', '2019-10-24')
# list.add_item('candy', '2019-10-31', '4 bags should be enough')
# list.toggle_item(1)
# list.print
# list.remove_item(0)
# p list

# p list.size
# p list.valid_index?(3)
# p list.valid_index?(1)
# p list.priority
# list.swap(0, 1)
# p list
# p list.priority
# p list[1]

# list.print
# puts

# list.print_full_item(2)
# list.print_priority
# puts list.down(0)
# list.print
# list.print_full_item(1)
# puts list.down(0, 2)
# list.print
# puts list.up(3, 10)
# list.print
# puts list.up(7, 3)

# list.sort_by_date!
# list.print
# list.purge
# list.print
# p list.toggle_item(2)

