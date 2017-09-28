require 'minitest/autorun'

# Definition for a binary tree node.
class TreeNode
    attr_accessor :val, :left, :right
    def initialize(val)
        @val = val
        @left, @right = nil, nil
    end
end

def inorder_successor(root, n)
  if n.val > root.val
    return inorder(n.right, nil)
  else
    return inorder(root, target)
  end
end

def inorder(root, target)
  order = []
  stack = []
  n = root
  found = false

  while !n.nil? do
    stack << n
    n = n.left
  end

  while !stack.empty? do
    n = stack.pop

    if found || target.nil?
      order << n
    end

    if n == target
      found = true
    end

    n = n.right
    while !n.nil? do
      stack << n
      n = n.left
    end
  end

  return order 
end

describe 'inorder_successor(root, n)' do
  it 'should work2' do
    n1 = TreeNode.new(10)
    n2 = TreeNode.new(2)
    n3 = TreeNode.new(3)
    n4 = TreeNode.new(4)
    n5 = TreeNode.new(5)

    n1.left = n2
    n2.right = n3
    n3.left = n4
    n4.right = n5

    #expected_result = [2, 4, 5, 3, 1]
    expected_result = [10]

    (inorder(n1, n3).map {|n| n.val}).must_equal(expected_result)


    expected_result = []
    (inorder(n2, n3).map {|n| n.val}).must_equal(expected_result)
  end
end

describe 'inorder' do
  it 'should work1' do
    n1 = TreeNode.new(10)
    n2 = TreeNode.new(2)
    n3 = TreeNode.new(3)
    n4 = TreeNode.new(4)
    n5 = TreeNode.new(5)

    n1.left = n2
    n2.right = n3
    n3.left = n4
    n4.right = n5

    expected_result = [2, 4, 5, 3, 10]

    (inorder(n1, nil).map {|n| n.val}).must_equal(expected_result)
  end
end
