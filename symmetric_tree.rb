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
# @return {Boolean}
def is_symmetric(root)
  if root.nil? || root.left.nil? && root.right.nil?
    return true
  end

  if root.left.nil? || root.right.nil?
    return false
  end

  ql = [root.left]
  qr = [root.right]

  while !ql.empty? do
    nl = ql.shift
    nr = qr.shift
    #puts "nl=#{nl}, val=#{nl.val}"
    #puts "nr=#{nr}, val=#{nr.val}"
    #puts "  nl.left=#{nl.left}"
    #puts "  nl.right=#{nl.right}, val=#{nl.right.val}"
    #puts "  nr.left=#{nr.left}"
    #puts "  nr.right=#{nr.right}"

    if nl.val != nr.val
      return false
    end

    if nl.left.nil?
      if !nr.right.nil?
        return false
      end
    else
      if nr.right.nil?
        return false
      else
        ql << nl.left
        qr << nr.right
      end
    end

    if nl.right.nil?
      if !nr.left.nil?
        return false
      end
    else
      #puts "shaobi"
      if nr.left.nil?
        return false
      else
        ql << nl.right
        qr << nr.left
      end
    end
  end
  return true
end

describe 'is_symmetric(root)' do
  it 'should work1' do
    n1 = TreeNode.new(1)
    n2 = TreeNode.new(2)
    n3 = TreeNode.new(2)
    n4 = TreeNode.new(3)
    n5 = TreeNode.new(4)
    n6 = TreeNode.new(4)
    n7 = TreeNode.new(3)

    n1.left = n2
    n1.right = n3
    n2.left = n4
    n2.right = n5
    n3.left = n6
    n3.right = n7

    expected_result = true
    is_symmetric(n1).must_equal(expected_result)

    n2.left = nil
    n2.right = n4
    n3.left = nil
    n3.right = n7
    expected_result = false
    is_symmetric(n1).must_equal(expected_result)
  end

  it 'should work2' do
    n1 = TreeNode.new(1)
    n2 = TreeNode.new(2)
    n3 = TreeNode.new(2)
    n4 = TreeNode.new(3)
    n5 = TreeNode.new(4)
    n6 = TreeNode.new(4)
    n7 = TreeNode.new(3)

    n1.left = n2
    n1.right = n3
    n2.left = n4
    n2.right = n5
    n3.left = nil
    n3.right = n7

    expected_result = false
    is_symmetric(n1).must_equal(expected_result)
  end
end
