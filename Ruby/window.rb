def windowed_max_range_v2(arr, window_size)
    current_max_range = nil

    i = 0
    while i < arr.length    #O(n) time
        current_range = arr[i...window_size+i].max - arr[i...window_size+i].min #O(n) time 
        current_max_range = current_range if current_max_range.nil? || current_max_range < current_range

        i += 1
    end

    current_max_range
end

puts "Time Complexity: O(n^2)"
t = Time.now
p windowed_max_range_v2([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range_v2([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range_v2([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p windowed_max_range_v2([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
p Time.now - t
 

class Queue
    def initialize
        @queue = []
    end

    def enqueue(val)   #O(1) time
        @queue.push(val)
    end

    def dequeue #O(n) time, reasgining indices
        @queue.shift
    end

    def peek
        @queue.last
    end

    def size
        @queue.size
    end

    def empty?
        @queue.empty?
    end
end

class Stack
    def initialize
        @stack = []
    end

    def push(val)
        @stack.push(val)
    end

    def pop 
        @stack.pop
    end

    def peek
        @stack.last
    end

    def size
        @stack.size
    end

    def empty?
        @stack.empty?
    end
end

class StackQueue
    def initialize
        @push_list = Stack.new
        @pop_list = Stack.new
    end

    def size
        @push_list.size + @pop_list.size
    end

    def empty?
        @push_list.empty? && @pop_list.empty?
    end

    def enqueue(val)
        @push_list.push(val)
    end
                            #         out <= [1,2,3,4] <= in
                            # OR     
                            #         [1,2,3,4] <= in
                            #         [4,3,2,1] => out
    def dequeue 
        queueifying if @pop_list.empty?   
        @pop_list.pop                      
    end                                    

private
    def queueifying
        @pop_list.push(@push_list.pop) until @push_list.empty?
    end 
end

class MinMaxStack
    def initialize
        @min_max_stack = Stack.new
    end

    def peek
        @min_max_stack.last
    end

    def size
        @min_max_stack.size
    end

    def empty?
        @min_max_stack.empty?
    end

    def max
        @min_max_stack.peek[:max]    #current max
    end

    def min
        @min_max_stack.peek[:min] 
    end

    def pop
        @min_max_stack.pop[:val]
    end

    def push(val)
        @min_max_stack.push({ max: new_max(val), min: new_min(val), val: val })
    end

private
    def new_min(val)
        empty? ? val : [val, min].min
    end

    def new_max(val)
        empty? ? val : [val, max].max
    end
end

class MinMaxStackQueue
    def initialize
        @push_list = MinMaxStack.new
        @pop_list = MinMaxStack.new
    end

    def enqueue(val)
        @push_list.push(val)
    end

    def dequeue
        queueifying if @pop_list.empty?
        @pop_list.pop
    end

    def min
        mins = []
        mins << @push_list.min unless @push_list.empty?
        mins << @pop_list.min unless @pop_list.empty?
        mins.min
    end

    def max
        maxes = []
        maxes << @push_list.max unless @push_list.empty?
        maxes << @pop_list.max unless @pop_list.empty?
        maxes.max
    end

    def size
        @push_list.size + @pop_list.size
    end

    def empty?
        @push_list.empty? && @pop_list.empty?
    end

private
    def queueifying
        @pop_list.push(@push_list.pop) until @push_list.empty?
    end
end

def windowed_max_range_v2(arr, window_size)
    current_max_range = nil
    queue = MinMaxStackQueue.new

    arr.each do |n|
        queue.enqueue(n)
        queue.dequeue if queue.size > window_size

        if queue.size == window_size
            current_range = queue.max - queue.min
            current_max_range = current_range if current_max_range.nil? || current_range > current_max_range
        end
    end

    current_max_range
end

if __FILE__ == $PROGRAM_NAME
    puts "Time Complexity: O(n)"
    t = Time.now
    p windowed_max_range_v2([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
    p windowed_max_range_v2([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
    p windowed_max_range_v2([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
    p windowed_max_range_v2([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
    p Time.now - t
end
