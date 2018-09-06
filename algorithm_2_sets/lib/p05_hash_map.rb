require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end


  def include?(key)
    @store[key.hash%num_buckets].include?(key)
  end

  def set(key, val)
    resize! if @count==num_buckets
    if include?(key)
      @store[key.hash%num_buckets].update(key, val)
     else
      @store[key.hash%num_buckets].append(key, val)
       @count += 1
     end

  end

  def get(key)
    @store[key.hash % num_buckets].get(key)
  end

  def delete(key)
    @store[key.hash%num_buckets].remove(key)
    @count-=1
  end

  def each
    @store.each do |k|
      k.each do |v|
        yield [v.key,v.val]
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    newCopy = Array.new(num_buckets*2) { LinkedList.new }
    currentStore=@store
    @store=newCopy
    currentStore.each do |k|
      k.each do |l|
        set(l.key, l.val)
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
