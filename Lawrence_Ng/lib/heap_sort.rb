require_relative "heap"

class Array
  def heap_sort!
    heap = BinaryMinHeap.new
    self.each do |k|
      heap.store << k
      BinaryMinHeap.heapify_up(heap.store, heap.store.length-1)
    end
    res = []
    until heap.store.empty?
      val = heap.extract
      res << val
      BinaryMinHeap.heapify_down(heap.store,0)
    end
    i = 0
    while (i < self.length)
      self[i] = res[i]
      i+=1
    end

  end
end
