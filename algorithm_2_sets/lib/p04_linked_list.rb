

class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
  end
end

class LinkedList
   include Enumerable

  def initialize
    @head = Node.new
    @tail=Node.new
    @head.next =@tail
    @tail.prev=@head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    return false if first!=@tail
    true
  end

  def get(key)
    n=@head.next
    while(n.key != key && n!=@tail)
      n=n.next
    end
    n.val
  end

  def include?(key)
    n=@head.next
    while(n.key != key && n!=@tail)
      n=n.next
    end
    return false if n==@tail
    return true
  end

  def append(key, val)
    node = Node.new(key,val)
    currentLast = @tail.prev
    currentLast.next=node
    @tail.prev = node
    node.next=@tail
    node.prev=currentLast
  end

  def update(key, val)
    n=@head.next
    while(n.key != key && n!=@tail)
      n=n.next
    end
    n.val=val
  end

  def remove(key)
    n=@head.next
    while(n.key!=key && n!=@tail)
      n=n.next
    end
    leftNode=n.prev
    rightNode=n.next
    leftNode.next =rightNode
    rightNode.prev=leftNode
  end

  def each
    n=@head.next
    while(n!=@tail)
      yield n
      n=n.next
    end
  end



  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
