class DynamicProgramming

  def initialize
    @blair_nums={ 1=>1, 2=>2}
    @frog_bottom_up = { 1 => [[1]], 2 => [[1,1],[2]]  }
  end


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


  end

  #4 =>[[1,1,1,1],[1,1,2],[1,2,1],[2,1,1],[2,2],[1,3],[3,1]]
  #5 => [ [1,1,1,1,1,], [1,1,2,1,1], [1,2,1,1], [2,1,2], [2,2,1], [2,1,1,1], [1,1,1,2,1], [1,1,1,2] [2,3],[3,2], [3,1,1],[1,3,1], [1,1,3]]
  def frog_cache_builder(n)
    cache={1=>[[1]],2=>[[1,1],[2]], 3=> [[1,1,1],[1,2],[2,1],[3]]}
    (4..n).each do |value|
      cache1 = cache[value-1]
      cache2 = cache[value-2]
      cache3 = cache[value-3]
      cache[value] =cache_builder_helper(cache1,cache2,cache3, value)
    end
    return cache
  end

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

  def cache_builder_helper(array, n)
    sum = array.reduce(:+)
    difference = n - sum
    tmp = array.dup
    tmp << difference
  end

  def frog_hops_top_down(n)

  end

  def frog_hops_top_down_helper(n)

  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
