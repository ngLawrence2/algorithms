class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc=prc
    @store=[]
  end

  def count
    @store.length
  end

  def extract
    return nil if @store.empty?
    tmp = @store[0]
    @store[0] = @store[@store.length-1]
    @store[@store.length-1] = tmp
    val = @store.pop
    BinaryMinHeap.heapify_down(@store,0)
    val
  end

  def peek
    @store.first
  end

  def push(val)
    @store << val
    BinaryMinHeap.heapify_up(@store,@store.length-1)
  end

  public
  def self.child_indices(len, parent_index)
    childLeft = parent_index*2 + 1
    childRight=parent_index*2+2
    return [childLeft,childRight] if childLeft && (childRight < len)
    return [childLeft] if (childLeft < len)
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index==0
    (child_index-1)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
   prc ||= Proc.new { |first,second| first<=>second}

    res=array
    currentVal = array[parent_idx]
    shouldSwap = false
    until shouldSwap

      # p currentVal.to_s + " im the current Value and my array is " + array.inspect
      childArray = BinaryMinHeap.child_indices(array.length , parent_idx)

      if childArray.nil?
        return res
      end
      # if !childArray[0].nil? && currentVal > array[childArray[0]] && array[childArray[0]] <= array[childArray[1]]

        # p "currentVal is " + currentVal.to_s + " compare value is " + array[childArray[0]].to_s + " prc result " + prc.call(currentVal, array[childArray[0]]).to_s
        # p "Comparing child elements - 1st: " + array[childArray[0]].to_s + " 2nd: " + array[childArray[1]].to_s + " prc result: " + prc.call(array[childArray[0]],array[childArray[1]]).to_s
          # p "this is childArray " + childArray.inspect
          if childArray.length == 1 && prc.call(currentVal,array[childArray[0]])>0
            tmp = array[parent_idx]
            array[parent_idx] = array[childArray[0]]
            array[childArray[0]] = tmp
            currentVal = array[childArray[0]]
            # p res.inspect + " im the result"
            parent_idx = childArray[0]
            next
          end

        if !childArray[0].nil? && prc.call(currentVal,array[childArray[0]])>0 && (childArray.length>1 && prc.call(array[childArray[0]], array[childArray[1]]) < 0)
        #perform a swap
        # p "im swapping left"
        tmp = array[parent_idx]
        array[parent_idx] = array[childArray[0]]
        array[childArray[0]] = tmp
        currentVal = array[childArray[0]]
        # p res.inspect + " im the result"
        parent_idx = childArray[0]
      elsif !childArray[1].nil? && prc.call(currentVal,array[childArray[1]])>0#currentVal > array[childArray[1]]
        # p "im swapping right"
        tmp = array[parent_idx]
        array[parent_idx] = array[childArray[1]]
        array[childArray[1]] = tmp
        currentVal = array[childArray[1]]
          parent_idx = childArray[1]
      else
        shouldSwap=true
      end
    end
    # p res.inspect + "array"
    res
  end


  def self.heapify_up(array, child_idx, len = array.length, &prc)
    res = array
    prc ||= Proc.new { |first,second| first<=>second}

    currentVal = array[child_idx]
    shouldSwap=false
    until shouldSwap
      parentIdx = BinaryMinHeap.parent_index(child_idx) if child_idx != 0
      # if currentVal < array[parentIdx]
      return res if parentIdx.nil?
      if prc.call(currentVal,array[parentIdx])<0
        #perform a swap
      
        tmp = array[parentIdx]
        array[parentIdx] = currentVal
        array[child_idx] = tmp
        child_idx = parentIdx
        shouldSwap = true if child_idx == 0
      else
        shouldSwap= true
      end
    end
    res
  end
end
