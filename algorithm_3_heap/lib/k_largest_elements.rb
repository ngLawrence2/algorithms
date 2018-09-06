require_relative 'heap'

def k_largest_elements(array, k)
  res = []
  prc = Proc.new do |el1, el2|
    -1 * (el1 <=> el2)
  end

  heap = BinaryMinHeap.new
  array.each_with_index do |k,idx|
    heap.store << k
    BinaryMinHeap.heapify_up(heap.store,idx, &prc)
  
  end

  until res.length == k
    val = heap.extract
    res << val
    BinaryMinHeap.heapify_down(heap.store,0, &prc)
  end
  res
end
