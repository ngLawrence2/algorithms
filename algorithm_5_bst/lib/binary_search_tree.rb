# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require 'bst_node'

class BinarySearchTree
  attr_accessor :root
  def initialize
    @root = nil
  end

  def insert(value)
    if @root.nil?
      @root=BSTNode.new(value)
    else
      insert_helper(value, @root)
    end
  end

  def insert_helper(val, root)
    #case 1 root is greater than value so we check the left
    if root.value > val
      #check if there is a child in the left side
      if root.left.nil?
        root.left = BSTNode.new(val)
      else
        insert_helper(val, root.left)
      end
    else
      #case 2 root is less than value so we check the right
      #check if there is a child in the right side
      if root.right.nil?
        root.right = BSTNode.new(val)
      else
        insert_helper(val,root.right)
      end
    end
  end


  def find(value, tree_node = @root)
    return tree_node if tree_node.value == value
    #we check the left if the tree_node value is greater than value
    if tree_node.value > value && tree_node.left.nil?
      return nil
    end
    if tree_node.value < value && tree_node.right.nil?
      return nil
    end
    if tree_node.value > value && !tree_node.left.nil?
      return find(value,tree_node.left)
    end
    if tree_node.value < value && !tree_node.right.nil?
      return find(value,tree_node.right)
    end
  end

  def delete(value)
    if @root.value == value
      @root=nil
    else
      delete_helper(value)
    end
  end

  def delete_helper(value, tree_node = @root)
    #case 1 tree node value is greater than value we check left
    if tree_node.value > value

      if tree_node.left.value == value
        deleteNode = tree_node.left
        #case 1a no children
        if deleteNode.left.nil? && deleteNode.right.nil?
          tree_node.left=nil
        end
        #case 1b left child
        if deleteNode.right.nil?
          tree_node.left = deleteNode.left
        end
        #case 1c right child
        if deleteNode.left.nil?
          tree_node.left = deleteNode.right
        end

        #case 1d 2 child
        if !deleteNode.left.nil? && !deleteNode.right.nil?
          replaceNode = maximum(deleteNode.left)
          tree_node.left = replaceNode
          delete_helper(replaceNode.value, deleteNode.left)
        end

      else
        delete_helper(value, tree_node.left)
      end
    else
      #case 2 tree node value is less than value we check right
      deleteNode=tree_node.right
      if tree_node.right.value == value
        if deleteNode.left.nil? && deleteNode.right.nil?
          tree_node.right=nil
        end
        if deleteNode.right.nil?
          tree_node.right = deleteNode.left
        end
        if deleteNode.left.nil?
          tree_node.right = deleteNode.right
        end
        if !deleteNode.left.nil? && !deleteNode.right.nil?
          replaceNode = maximum(deleteNode.left)
          tree_node.right = replaceNode
          delete_helper(replaceNode.value, deleteNode.left)
        end
      else
        delete_helper(value, tree_node.right)
      end
    end
  end


  # helper method for #delete:
  def maximum(tree_node = @root)
    if tree_node.right.nil?
      return tree_node
    else
      maximum(tree_node.right)
    end
  end

  def depth(tree_node = @root)
    return 0 if tree_node.nil?
    leftRes = 0
    rightRes = 0
    if !tree_node.left.nil?
      leftRes = leftRes + 1 + depth(tree_node.left)
    end
    if !tree_node.right.nil?
      rightRes = rightRes + 1 + depth(tree_node.right)
    end
    [leftRes,rightRes].max
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?
    left = depth(tree_node.left)
    right=depth(tree_node.right)
    res = (left-right).abs
    return false if res > 1
    return is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
  end

  def post_order_traversal(tree_node=@root, arr=[])
    if !tree_node.left.nil?
      post_order_traversal(tree_node.left, arr)
    end
    if !tree_node.right.nil?
       post_order_traversal(tree_node.right, arr)
    end
    arr<< tree_node.value
    return arr
  end

  def in_order_traversal(tree_node = @root, arr = [])
    # if !tree_node.left.nil?
    #   in_order_traversal(tree_node.left, arr)
    # end
    # arr<< tree_node.value
    # if !tree_node.right.nil?
    #    in_order_traversal(tree_node.right, arr)
    # end
    # return arr
    stack = [tree_node]
    res = []
    return [] if tree_node.nil?
    until stack.empty?
      if  !tree_node.nil? && !tree_node.left.nil?
        tree_node=tree_node.left
        stack << tree_node
      else
        val = stack.pop
        res << val.value
        if !val.nil? && !val.right.nil?
          tree_node=val.right
          stack << tree_node
        end
      end
    end
    res
  end

  def bfs(tree_node=@root)
    res = []
    queue = [tree_node]
    until queue.empty?
      node = queue.shift
      res << node.value
      queue << node.left if !node.left.nil?
      queue << node.right if !node.right.nil?
    end
    res
  end

  def dfs_pre_order(tree_node=@root)
    res = []
    stack = [tree_node]
    until stack.empty?
      node = stack.pop
      res << node.value
      stack << node.right if !node.right.nil?
      stack << node.left if !node.left.nil?
    end
    res
  end




  def inverse(tree_node=@root)
    rootCopy = tree_node
    queue = [tree_node]
    until queue.empty?
      node = queue.shift
      node.left,node.right = node.right,node.left
      queue << node.left if !node.left.nil?
      queue << node.right if !node.right.nil?
    end
    p in_order_traversal(rootCopy)
  end

  private
  # optional helper methods go here:

end
