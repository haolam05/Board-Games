  class Stack
    def initialize
      @stack = []
    end

    def push(el)
      @stack.push(el)
    end

    def pop
      @stack.pop
    end

    def peek  #the one about to get out
      @stack.last
    end
  end

p s = Stack.new
s.push(1)
p s
s.push(2)
p s
s.push(3)
p s

p s.peek

s.pop
p s
s.pop
p s
s.pop
p s

p s.peek