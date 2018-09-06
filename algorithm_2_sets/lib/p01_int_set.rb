class MaxIntSet
  def initialize(max)
    @store=Array.new(max)
  end

  def insert(num)
    if is_valid?(num)
      @store[num] = true
    end
  end

  def remove(num)
    @store[num]=nil
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    raise 'Out of bounds' if num < 0 || num >= @store.length
    true
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
     @store[num%num_buckets] = num
  end

  def remove(num)
    @store[num%num_buckets]=[]
  end

  def include?(num)
    @store.include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == num_buckets
    @store[num] = num
    @count+=1
  end

  def remove(num)
    @store.delete(num)
    @count-=1
  end

  def include?(num)
    @store.include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
  end

  def num_buckets
    @store.length
  end

  def resize!
    newCopy = Array.new(num_buckets*2) { Array.new}
    i = 0
    while i < num_buckets
      newCopy[i]=@store[i]
      i+=1
    end
    @store=newCopy
  end
end
