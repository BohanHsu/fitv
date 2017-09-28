require 'minitest/autorun'

# Definition for a binary tree node.
class TreeNode
    attr_accessor :val, :left, :right
    def initialize(val)
        @val = val
        @left, @right = nil, nil
    end
end

# @param {TreeNode} s
# @param {TreeNode} t
# @return {Boolean}
def is_subtree(s, t)
  queue = [s]

  while !queue.empty? do
    n = queue.shift
    if n.val == t.val
      result = compare(n, t)
      if result
        return true
      end
    end

    if !n.left.nil?
      queue << n.left
    end

    if !n.right.nil?
      queue << n.right
    end
  end

  return false
end

def compare(t1, t2)
  q1 = [t1]
  q2 = [t2]

  while !q1.empty? do
    n1 = q1.shift
    n2 = q2.shift
    if n1.val != n2.val
      return false
    end

    if !n1.left.nil? && !n2.left.nil?
      q1 << n1.left
      q2 << n2.left
    elsif n1.left.nil? && n2.left.nil?
      # do nothing
    else
      return false
    end

    if !n1.right.nil? && !n2.right.nil?
      q1 << n1.right
      q2 << n2.right
    elsif n1.right.nil? && n2.right.nil?
      # do nothing
    else
      return false
    end
  end

  return true
end

describe 'is_subtree(s, t)' do
  it 'should work1' do
    s1 = TreeNode.new(3)
    s2 = TreeNode.new(4)
    s3 = TreeNode.new(5)
    s4 = TreeNode.new(1)
    s5 = TreeNode.new(2)

    s1.left = s2
    s1.right = s3
    s2.left = s4
    s2.right = s5

    t1 = TreeNode.new(4)
    t2 = TreeNode.new(1)
    t3 = TreeNode.new(2)
    t1.left = t2
    t1.right = t3

    expected_result = true
    is_subtree(s1, t1).must_equal(expected_result)

    s6 = TreeNode.new(0)
    s5.left = s6

    expected_result = false
    is_subtree(s1, t1).must_equal(expected_result)
  end
end
