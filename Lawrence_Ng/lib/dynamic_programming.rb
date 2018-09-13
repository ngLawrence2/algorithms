require 'byebug'

class DynamicProgramming

  def initialize
    @blair_nums={ 1=>1, 2=>2}
    @frog_top_down = { 1 => [[1]], 2 => [[1,1],[2]], 3 => [[1,1,1], [1,2], [2,1], [3]]  }
    @super_frog={}
    @knapsack=[]
  end

  #get nth odd number
  def getOdd(n)
    (2*n)-1
  end

  #kth = k -1st odd number
  def blair_nums(n)
    return n if n <=2
    return @blair_nums[n] if @blair_nums[n]
    result = blair_nums(n-1) + blair_nums(n-2) + getOdd(n-1)
    @blair_nums[n] = result
  end


  def frog_hops_bottom_up(n)
    return frog_cache_builder(n)
  end

  #4 =>[[1,1,1,1],[1,1,2],[1,2,1],[2,1,1],[2,2],[1,3],[3,1]]
  #5 => [ [1,1,1,1,1,], [1,1,2,1,1], [1,2,1,1], [2,1,2], [2,2,1], [2,1,1,1], [1,1,1,2,1], [1,1,1,2] [2,3],[3,2], [3,1,1],[1,3,1], [1,1,3]]
  def frog_cache_builder(n)
    cache={1=>[[1]],2=>[[1,1],[2]], 3=> [[1,1,1],[1,2],[2,1],[3]]}
    (4..n).each do |value|
      cache1 = cache[value-1]
      cache2 = cache[value-2]
      cache3 = cache[value-3]
      cache[value] = cache_builder(cache1,cache2,cache3, value)
    end
    return cache[n]
  end

  #iterates through all the 2d array and gives result of all arrays that sum up to the value
  def cache_builder(cache1, cache2, cache3, value)
    result = []
    cache1.each do |array|
        result << cache_builder_helper(array, value)
    end

    cache2.each do |array|
      result << cache_builder_helper(array, value)
    end

    cache3.each do |array|
      result << cache_builder_helper(array, value)
    end

    result
  end

  #given an array, sums all the values up and inserts difference
  #ex : [1,1,2] , 5 =>   [1,1,2,1]
  def cache_builder_helper(array, n)
    sum = array.reduce(:+)
    difference = n - sum
    tmp = array.dup
    tmp << difference
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
    @frog_top_down[n]
  end

  def frog_hops_top_down_helper(n)
    return @frog_top_down[n] if n <=3
    return @frog_top_down[n] if @frog_top_down[n]
    frog_hops_top_down_helper(n-1)
    cache1 = frog_hops_top_down_helper(n-1)
    cache2 = frog_hops_top_down_helper(n-2)
    cache3 = frog_hops_top_down_helper(n-3)
    result = cache_builder(cache1,cache2,cache3,n)
    @frog_top_down[n]=result
  end

  def super_frog_hops(n, k)
    # cache = Hash.new { |h,k| h[k]=[]}
    cache=[[]]
    (1..n).each do |i|
      cache[i] << [i] if i <= k
      var = i > k ? k : i - 1
      (1..var).each do |val|
        cache[i] += cache[i-val].map{|el| el + [val]}
      end
    end
    cache[n]
  end

  def knapsack(weights, values, capacity)
    table = knapsack_table(weights,values,capacity)
    table[-1][-1]
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    table = Array.new(weights.length) { [0]}
    (0..values.length-1).each do |currentItem|
      (1..capacity).each do |currentWeight|

          if (currentWeight < weights[currentItem])
            if currentItem == 0
              table[currentItem] << 0
            else
              table[currentItem] << table[currentItem-1][currentWeight]
            end
          else
            #current weight is bigger than weight
            #check for if we are at the top row
            if currentItem == 0
              table[currentItem] << values[currentItem]
            else
              difference = currentWeight - weights[currentItem]
              leftover = table[currentItem-1][difference] + values[currentItem]
              prevResult = table[currentItem-1][currentWeight]
              table[currentItem] << [leftover,prevResult].max
            end
          end
      end
    end
    table
  end


def getMaxValueFromWeight(weights,values,capacity)
  result = 0
  (0..values.length-1).each do |idx|
    result = values[idx] if (values[idx]>result && weights[idx]<=capacity )
  end
  result
end


  def maze_solver(maze, start_pos, end_pos)
  end
end
