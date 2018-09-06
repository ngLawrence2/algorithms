require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    @store[@count%num_buckets] << key
    @count+=1
  end

  def include?(key)

    @store.each do |k|
      return true if k.first == key
    end
    false
  end

  def remove(key)
    @store.each do |k|
      k.clear if k[0]==key
    end
    @count-=1
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
    newCopy = Array.new(num_buckets*2){Array.new}
    i=0
    while(i < num_buckets)
      newCopy[i]=@store[i]
      i+=1
    end
    @store=newCopy
  end
end
