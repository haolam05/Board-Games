  class Queue
    def initialize
      @queue = []
    end

    def enqueue(el)
      @queue.push(el)
    end

    def dequeue
      @queue.shift
    end

    def peek  #the one is about to get out
      @queue.first
    end
  end

p q = Queue.new
q.enqueue(1)
p q
q.enqueue(2)
p q
q.enqueue(3)
p q

p q.peek

q.dequeue
p q
q.dequeue
p q
q.dequeue
p q

p q.peek