class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val)
    @val = val
  end
end

def array_to_tree(arr)
  return nil if arr.empty?

  idx_to_node = {0 => TreeNode.new(arr[0])}
  i = 1
  j = 1
  while j < arr.length do
    while !idx_to_node.has_key?((i - 1) / 2) || idx_to_node[(i - 1) / 2].nil? do
      i += 1
    end
    node = nil
    if !arr[j].nil?
      node = TreeNode.new(arr[j])
    end
    idx_to_node[i] = node
    i += 1
    j += 1
  end

  idx_to_node.each do |key, node|
    if key != 0
      if key % 2 == 1
        # left
        idx_to_node[(key - 1) / 2].left = node
      else
        idx_to_node[(key - 1) / 2].right = node
      end
    end
  end

  return idx_to_node[0]
end

def tree_to_array(root)
  return [] if root.nil?

  idx_to_node = {}
  node_to_idx = {}
  
  queue = [root]
  idx_to_node[0] = root
  node_to_idx[root] = 0

  while !queue.empty? do
    n = queue.shift
    idxn = node_to_idx[n]
    idx_to_node[idxn * 2 + 1] = n.left
    idx_to_node[idxn * 2 + 2] = n.right

    if !n.left.nil?
      queue << n.left
      node_to_idx[n.left] = idxn * 2 + 1
    end

    if !n.right.nil?
      queue << n.right
      node_to_idx[n.right] = idxn * 2 + 2
    end
  end

  result = []
  (0..idx_to_node.keys.max).each do |key|
    if idx_to_node.has_key?(key)
      node = nil
      if !idx_to_node[key].nil?
        node = idx_to_node[key].val
      end
      result << node
    end
  end

  while !result.empty? && result.last.nil? do
    result.pop
  end
  return result
end
