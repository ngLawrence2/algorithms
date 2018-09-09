class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if self.length <=1
    pivotEl=array[0]
    left = array[1..-1].select{|el| el <=pivotEl}
    right=array[1..-1].select{|el| el >pivotEl}
    QuickSort.sort1(left)+[pivotEl]+QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if (length-start)<=1
    prc ||= Proc.new{ |a,b| a<=>b}
    if start < length
      randPiv = rand(start..length)
      pivotIdx = QuickSort.partition(array,start,length,&prc)
      QuickSort.sort2!(array, start, pivotIdx, &prc)
      QuickSort.sort2!(array,pivotIdx+1,length,&prc)
    end
    array
  end

  def self.partition(array, start, length, &prc)
    prc||=Proc.new{|a,b|a<=>b}
    pivotIdx=start
    start+=1
    partitionIdx = start
     until start >= (pivotIdx+length)
      val = array[start]
      if val && prc.call(val,array[pivotIdx]) < 0
        array[partitionIdx],array[start]=array[start],array[partitionIdx]
        partitionIdx+=1
        # start+=1
      end  #val is greater than pivotIdx
        start+=1
  
    end
      array[pivotIdx],array[partitionIdx-1]=array[partitionIdx-1],array[pivotIdx]
      partitionIdx-=1
  end
end
