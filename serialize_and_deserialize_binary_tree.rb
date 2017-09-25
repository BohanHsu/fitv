require 'minitest/autorun'

# Definition for a binary tree node.
class TreeNode
    attr_accessor :val, :left, :right
    def initialize(val)
        @val = val
        @left, @right = nil, nil
    end
end

# Encodes a tree to a single string.
# @param {TreeNode} root
# @return {string}
def serialize(root)
  return "" if root.nil?
  queue = [root]
  map = {root => 0}
  result = {0 => root}
  
  while !queue.empty? do
    n = queue.shift

    idx = map[n]

    if !n.left.nil?
      lidx = idx * 2 + 1
      map[n.left] = lidx
      result[lidx] = n.left
      queue << n.left
    end

    if !n.right.nil?
      ridx = idx * 2 + 2
      map[n.right] = ridx
      result[ridx] = n.right
      queue << n.right
    end
  end


  array = []
  result.each do |k, v|
    array << "#{k}:#{v.val}"
  end
  return array.join(",")
end

# Decodes your encoded data to tree.
#
# @param {string} data
# @return {TreeNode}
def deserialize(data)
  array = data.split(",")
  idx_to_val = {}
  array.each do |str|
    kv = str.split(':')
    idx_to_val[kv[0].to_i] = kv[1].to_i
  end

  idx_to_node = {}

  idx_to_val.each do |k, v|
    stack = [k]

    while !stack.empty? do
      if !idx_to_node.has_key?(stack.last)
        parent_idx = (stack.last - 1) / 2

        if stack.last == 0 || idx_to_node.has_key?(parent_idx)
          new_node = TreeNode.new(idx_to_val[stack.last])
          idx_to_node[stack.last] = new_node
          if stack.last !=0 && stack.last % 2 == 1
            idx_to_node[parent_idx].left = new_node
          elsif stack.last !=0 && stack.last % 2 == 0
            idx_to_node[parent_idx].right = new_node
          end
        else
          stack << parent_idx
        end
      else
        stack.pop
      end
    end
  end
  return idx_to_node[0]
end

# Encodes a tree to a single string.
# @param {TreeNode} root
# @return {string}
def serialize1(root)
  if root.nil?
    return []
  end

  queue = [root]
  map = {root => 0}
  max_idx = -1

  nil_queue = {}

  while !queue.empty? do
    n = queue.shift

    if map[n] > max_idx
      max_idx = map[n]
    end

    if !n.left.nil?
      queue << n.left
      map[n.left] = map[n] * 2 + 1
    else
      nil_queue[map[n] * 2 + 1] = nil
    end

    if !n.right.nil?
      queue << n.right
      map[n.right] = map[n] * 2 + 2
    else
      nil_queue[map[n] * 2 + 2] = nil
    end
  end

  map2 = {}
  map.each do |k, v|
    map2[v] = k
  end

  nil_queue.each do |k, v|
    map2[k] = v
  end

  result = []
  (0..max_idx).each do |i|
    if map2.has_key?(i)
      if map2[i].nil?
        result << nil
      else
        result << map2[i].val
      end
    end
  end

  return result
end

# Decodes your encoded data to tree.
#
# @param {string} data
# @return {TreeNode}
def deserialize1(data)
  if data.empty?
    return nil
  end

  root = TreeNode.new(data.shift)
  map = {0 => root}
  idx = 1

  while !data.empty? do
    val = data.shift
    while !map.has_key?((idx - 1) / 2)
      idx += 1
    end

    if val.nil?
      n = nil
    else
      n = TreeNode.new(val)
      map[idx] = n
    end

    if idx % 2 == 1
      map[(idx - 1) / 2].left = n
    else
      map[(idx - 1) / 2].right = n
    end
    idx += 1
  end
  return root
end


# Your functions will be called as such:
# deserialize(serialize(data))

describe 'functions' do
  it 'should work1' do
    n1 = TreeNode.new(1)
    n2 = TreeNode.new(2)
    n3 = TreeNode.new(3)
    n4 = TreeNode.new(4)
    n5 = TreeNode.new(5)

    n1.left = n2
    n1.right = n3
    n3.left = n4
    n4.right = n5

    #p n1

    array = serialize(n1)
    #p array

    nn1 = deserialize(array)

    #p nn1

    nn1.val.must_equal(1)
    nn1.left.wont_equal(nil)
    nn1.right.wont_equal(nil)

    nn2 = nn1.left
    nn3 = nn1.right
    nn2.val.must_equal(2)
    nn3.val.must_equal(3)

    nn2.left.must_equal(nil)
    nn2.right.must_equal(nil)

    nn3.left.wont_equal(nil)
    nn3.right.must_equal(nil)
    nn3.val.must_equal(3)

    nn4 = nn3.left
    nn4.val.must_equal(4)
    nn4.left.must_equal(nil)
    nn4.right.wont_equal(nil)

    nn5 = nn4.right
    nn5.val.must_equal(5)
    nn5.left.must_equal(nil)
    nn5.right.must_equal(nil)
  end
end
