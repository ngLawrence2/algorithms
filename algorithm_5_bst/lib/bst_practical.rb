def kth_largest(tree_node, k, arr=[])
  unless tree_node.right.nil?
    kth_largest(tree_node.right,k,arr)
      return arr.last if arr.count==k
  end
  arr << tree_node
  return arr.last if arr.count==k
  unless tree_node.left.nil?
    kth_largest(tree_node.left,k,arr)
      return arr.last if arr.count==k
  end
end
