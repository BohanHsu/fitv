require 'minitest/autorun'
require './tree_utils'

def inorder(root)
  result = []

  n = root
  stack = []

  while !n.nil? do
    stack << n
    n = n.left
  end

  while !stack.empty? do
    n = stack.pop
    #visit(n)
    result << n.val
    
    n = n.right

    while !n.nil? do
      stack << n
      n = n.left
    end
  end

  return result
end

def preorder(root)
  result = []
  stack = [root]

  while !stack.empty? do
    n = stack.pop
    #visit(n)
    result << n.val

    if !n.right.nil?
      stack << n.right
    end

    if !n.left.nil?
      stack << n.left
    end
  end
  return result
end

def postorder(root)
  result = []
  stack = []
  n = root
  while !n.nil? do
    stack << n
    if !n.left.nil?
      n = n.left
    else
      n = n.right
    end
  end

  while !stack.empty? do
    if n == stack.last.right
      n = stack.pop
      result << n.val
    else

      # n == stack.last.left
      n = stack.last.right
      while !n.nil? do
        stack << n
        if !n.left.nil?
          n = n.left
        else
          n = n.right
        end
      end
    end

  end

  return result
end

describe 'inorder(root)' do
  it 'should inorder traverse' do
    arr = [0,1,2,3,nil,nil,nil,nil,4,5]
    root = array_to_tree(arr)
    expected_result = [3,5,4,1,0,2]
    inorder(root).must_equal(expected_result)
  end
end

describe 'preorder(root)' do
  it 'should preorder traverse' do
    arr = [0,1,2,3,nil,nil,nil,nil,4,5]
    root = array_to_tree(arr)
    expected_result = [0,1,3,4,5,2]
    preorder(root).must_equal(expected_result)
  end
end

describe 'postorder(root)' do
  it 'should postorder traverse' do
    arr = [0,1,2,3,nil,nil,nil,nil,4,5]
    root = array_to_tree(arr)
    expected_result = [5,4,3,1,2,0]
    postorder(root).must_equal(expected_result)
  end
end
