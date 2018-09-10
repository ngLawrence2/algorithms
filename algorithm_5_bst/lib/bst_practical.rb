require 'binary_search_tree'

def kth_largest(tree_node, k)
  tree=BinarySearchTree.new
  tree.root=tree_node
  arr = tree.in_order_traversal
  value = arr[arr.length-k]
  tree.find(value)
end
