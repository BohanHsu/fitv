require 'minitest/autorun'

# Definition for a binary tree node.
class TreeNode
    attr_accessor :val, :left, :right
    def initialize(val)
        @val = val
        @left, @right = nil, nil
    end
end

# @param {TreeNode} root
# @return {String[]}
def binary_tree_paths(root)
  return [] if root.nil?
  queue = [root]
  parent = {}
  leaves = []

  while !queue.empty? do
    n = queue.shift
    if !n.left.nil?
      queue << n.left
      parent[n.left] = n
    end

    if !n.right.nil?
      queue << n.right
      parent[n.right] = n
    end

    if n.left.nil? && n.right.nil?
      leaves << n
    end
  end

  return leaves.map do |n|
    reverse_list = []
    while !n.nil? do
      reverse_list << n.val
      n = parent[n]
    end

    reverse_list.reverse.join("->")
  end
end

describe 'binary_tree_paths(root)' do
  it 'should work1' do
    n1 = TreeNode.new(1)
    n2 = TreeNode.new(2)
    n3 = TreeNode.new(3)
    n5 = TreeNode.new(5)
    n1.left = n2
    n1.right = n3
    n2.right = n5

    expected_result = ["1->2->5", "1->3"]

    binary_tree_paths(n1).sort.must_equal(expected_result.sort)
  end
end
