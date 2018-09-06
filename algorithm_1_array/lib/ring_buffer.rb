require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store=StaticArray.new(0)
    @length=0
    @capacity=8
    @start_idx=0
  end

  # O(1)
  def [](index)
    raise 'index out of bounds' if index >=@length
    @store[(@start_idx+index) % @capacity]
  end

  # O(1)
  def []=(index, value)
    @store[(@start_idx+index) % @capacity] = value
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length ==0
    currentIdx = (@start_idx + @length-1) % @capacity
    val = @store[currentIdx]
    @store[currentIdx]=nil
    @length-=1
    val
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    currentIdx=(@start_idx+@length)% @capacity
    @store[currentIdx] = val
    @length+=1
  end

  # O(1)
  def shift
    raise 'index out of bounds' if @length ==0
    @length-=1
    @start_idx = @start_idx % @capacity
    val = @store[@start_idx]
    @store[@start_idx]=nil
    @start_idx+=1
    val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length==@capacity
      @start_idx-=1
      @start_idx = @start_idx % @capacity
      @store[@start_idx]=val
      @length+=1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    newStaticArray = StaticArray.new(@length*2)
    idx = 0
    while (idx < @capacity)
      newStaticArray[idx] = @store[(@start_idx + idx) % @capacity]
      idx+=1
    end
    @start_idx=0
    @capacity *=2
    @store=newStaticArray
  end
end
