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
      @root = BSTNode.new(value)
    else
      insert_helper(value,@root)
    end
  end

  def insert_helper(val, root)
    if val < root.value
      insert_helper(val,root.left) unless root.left.nil?
      if root.left.nil?
        root.left = BSTNode.new(val)
        return
      end
    else
      insert_helper(val,root.right) unless root.right.nil?
      if root.right.nil?
        root.right = BSTNode.new(val)
        return
      end
    end
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    return tree_node if value == tree_node.value
    if value < tree_node.value
      #on left side
      return find(value, tree_node.left)
    else
      #on right side
      return find(value,tree_node.right)
    end
  end

  def delete(value)
      if @root.value == value
        @root = nil
        return
      end
     delete_node(value)
  end

  def delete_node(value,tree_node=@root)
    currentVal =  tree_node.value
    #compare currentVal and value to see which way to go
    p currentVal.to_s + " <<= current"
    direction = currentVal <=> value
    if direction > 0  # we check our left child
      if tree_node.left.value == value
        deleteNode = tree_node.left
        # node to delete has no child
        if deleteNode.left.nil? && deleteNode.right.nil?
          tree_node.left=nil
          return
        end
        if deleteNode.left.nil?
          #we have a right child
          tree_node.right = deleteNode.right
        elsif deleteNode.right.nil?
          #we have a left child
          tree_node.left=deleteNode.left
        else
          #we have both child
        end
      else
        delete_node(value,tree_node.left)
      end
    else  #we check our right child
      if tree_node.right.value == value
          #check if we have any children
          deleteNode=tree_node.right
          if deleteNode.left.nil? && deleteNode.right.nil?
            tree_node.right=nil
            return
          end
          if deleteNode.left.nil?
            #we have a right child
            tree_node.right = deleteNode.right
            return
          elsif deleteNode.right.nil?
            #we have a left child
            tree_node.left= deleteNode.left
          else
            #we have both child
          end
      else
        delete_node(value,tree_node.right)
      end
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node if tree_node.right.nil?
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
    return 0 if tree_node.nil? || (tree_node.right.nil? && tree_node.left.nil?)
    right=depth(tree_node.right)+1
    left=depth(tree_node.left)+1
    [left,right].max
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?
    left = depth(tree_node.left)
    right = depth(tree_node.right)
    return false if (left-right).abs > 1
    return is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
  end

  def in_order_traversal(tree_node = @root, arr = [])
      unless tree_node.left.nil?
        in_order_traversal(tree_node.left,arr)
      end
      arr << tree_node.value
      unless tree_node.right.nil?
        in_order_traversal(tree_node.right,arr)
      end
      arr
  end


  private
  # optional helper methods go here:

end
