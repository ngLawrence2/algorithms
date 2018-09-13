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
          replaceNode=maximum(deleteNode.left)
          tree_node.left=replaceNode
          delete_node(replaceNode.value,deleteNode.left)
          return
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
            tree_node.right = deleteNode.left
          else
            #we have both child
            # replace with the maximum of the left subtree
            #call delete on the left sub tree of the value that was promoted
            replaceNode = maximum(deleteNode.right)
            tree_node.right=replaceNode
            delete_node(replaceNode.value,deleteNode.left)
            return
            # p in_order_traversal.inspect
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




#
# require 'bst_node'
# require 'byebug'
#
# class BinarySearchTree
#   attr_reader :root
#
#   def initialize
#     @root = nil
#   end
#
#   def insert(value)
#     # setting the root here in case it is still nil
#     @root = insert_into_tree(@root, value)
#   end
#
#   def find(value, tree_node = @root)
#     return nil if tree_node.nil?
#     return tree_node if tree_node.value == value
#
#     if value < tree_node.value
#       find(value, tree_node.left)
#     elsif value > tree_node.value
#       find(value, tree_node.right)
#     end
#   end
#
#   def delete(value)
#     @root = delete_from_tree(@root, value)
#   end
#
#   def maximum(tree_node = @root)
#     if tree_node.right
#       maximum_node = maximum(tree_node.right)
#     else
#       maximum_node = tree_node
#     end
#     maximum_node
#   end
#
#   def depth(tree_node = @root)
#     if tree_node.nil?
#       return -1;
#     else
#       left_depth = depth(tree_node.left)
#       right_depth = depth(tree_node.right)
#
#       if left_depth > right_depth
#         return left_depth + 1
#       else
#         return right_depth + 1
#       end
#     end
#   end
#
#   def is_balanced?(tree_node = @root)
#     return true if tree_node.nil?
#
#     balanced = true
#     left_depth = depth(tree_node.left)
#     right_depth = depth(tree_node.right)
#     balanced = false if (left_depth - right_depth).abs > 1
#
#     if balanced && is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
#       return true
#     end
#
#     false
#   end
#
#   def in_order_traversal(tree_node = @root, arr = [])
#     # left children, itself, right children
#     if tree_node.left
#       in_order_traversal(tree_node.left, arr)
#     end
#
#     arr.push(tree_node.value)
#
#     if tree_node.right
#       in_order_traversal(tree_node.right, arr)
#     end
#
#     arr
#   end
#
#
#
#   private
#
#   def insert_into_tree(tree_node, value)
#     # return the tree with the node inserted
#
#     return BSTNode.new(value) if tree_node.nil?
#
#     if value <= tree_node.value
#       tree_node.left = insert_into_tree(tree_node.left, value)
#     elsif value > tree_node.value
#       tree_node.right = insert_into_tree(tree_node.right, value)
#     end
#
#     tree_node
#   end
#
#   def delete_from_tree(tree_node, value)
#     # return subtree with element removed
#
#     # if correct node is found, then call remove on it.
#     # otherwise, recurse until you find it
#
#     if value < tree_node.value
#       tree_node.left = delete_from_tree(tree_node.left, value)
#     elsif value > tree_node.value
#       tree_node.right = delete_from_tree(tree_node.right, value)
#     elsif value == tree_node.value
#       tree_node = remove(tree_node)
#     end
#
#     tree_node
#   end
#
#   def remove(node)
#     # return subtree with element removed
#
#     if node.left.nil? && node.right.nil?
#       # when node doesn't have children,
#       # simply remove it.
#       return nil
#     elsif node.left && node.right.nil?
#       # when node only has one child,
#       # delete it and promote its child to take its place.
#       return node.left
#     elsif node.left.nil? && node.right
#       return node.right
#     else
#       # if node has two children,
#       # promote the maximum node in its left subtree to replace itself
#       # if that specific node that was promoted has children,
#       # then promote
#       return replace_parent(node)
#     end
#   end
#
#   def replace_parent(parent)
#     # parent has two children
#     # 1 needs to be promoted
#
#     replacement_node = maximum(parent.left)
#     if replacement_node.left
#       promote_child(parent.left)
#     end
#
#     # since the replacement_node is still pointing to its old children,
#     # we have to update its children pointers
#     replacement_node.left = parent.left
#     replacement_node.right = parent.right
#
#     replacement_node
#   end
#
#   def promote_child(tree_node)
#     # find largest and take it out
#     # largest is guaranteed to have at most 1 child
#     # so promotion is simple
#
#     if tree_node.right
#       parent = tree_node
#       child = tree_node.right
#
#       while child.right
#         parent = parent.right
#         child = child.right
#       end
#
#       parent.right = child.left
#     end
#   end
# end
