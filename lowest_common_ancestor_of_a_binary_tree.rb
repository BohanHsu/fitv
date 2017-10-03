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
# @param {TreeNode} p
# @param {TreeNode} q
# @return {TreeNode}
def lowest_common_ancestor(root, p, q)
  if p == q
    return p
  end

  if p == nil
    return q
  end

  if q == nil
    return p
  end

  if q == p.left || q == p.right
    return p
  end

  if p == q.left || q == p.right
    return q
  end

  parent = {}
  queue = [root]

  while !queue.empty? && (!parent.has_key?(p) || !parent.has_key?(q)) do
    n = queue.shift
    if !n.left.nil?
      queue << n.left
      parent[n.left] = n
    end

    if !n.right.nil?
      queue << n.right
      parent[n.right] = n
    end
  end

  acc_p = []
  n = p
  while n != nil do
    acc_p << n
    n = parent[n]
  end
  acc_p.reverse!

  acc_q = []
  n = q
  while n != nil do
    acc_q << n
    n = parent[n]
  end
  acc_q.reverse!

  #puts "====="
  #acc_p.each do |node|
  #  puts node.val
  #end

  #puts "====="
  #acc_q.each do |node|
  #  puts node.val
  #end

  i = 0
  j = 0

  prev = nil
  while i < acc_p.length && j < acc_q.length && acc_p[i] == acc_q[j] do
    prev = acc_p[i]
    i += 1
    j += 1
  end

  return prev
end

describe 'lowest_common_ancestor(root, p, q)' do
  it 'should work1' do
    n0 = TreeNode.new(0)
    n1 = TreeNode.new(1)
    n2 = TreeNode.new(2)
    n3 = TreeNode.new(3)
    n4 = TreeNode.new(4)
    n5 = TreeNode.new(5)
    n6 = TreeNode.new(6)
    n7 = TreeNode.new(7)
    n8 = TreeNode.new(8)

    n3.left = n5
    n3.right = n1
    n5.left = n6
    n5.right = n2
    n2.left = n7
    n2.right = n4
    n1.left = n0
    n1.right = n8

    lowest_common_ancestor(n3, n1, n5).must_equal(n3)
    lowest_common_ancestor(n3, n4, n5).must_equal(n5)
  end
end
