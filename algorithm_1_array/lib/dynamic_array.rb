require_relative "static_array"

class DynamicArray
  attr_reader :length
  def initialize
    @store=StaticArray.new(0)
    @length = 0
    @capacity=8
  end

  # O(1)
  def [](index)
    raise 'index out of bounds' if index >=@length
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index]=value
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length ==0
    val = @store[@length-1]
    @store[@length-1]=nil
    @length-=1
    val
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length]=val
    @length+=1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise 'index out of bounds' if @length == 0
    current = @length - 1
    tmp = @store[current]
    while (current >= 0 )
      tmp = @store[current-1]
      @store[current-1] = @store[current]
      current -=1
    end
    @length-=1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    current = @length - 1
    while(current >= 0)
      p @store
      @store[current+1] = @store[current]
      current-=1
    end
    @length+=1
    @store[0]=val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity = @capacity * 2
  end
end
