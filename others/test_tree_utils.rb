require 'minitest/autorun'
require './tree_utils'

describe 'array_to_tree(arr)' do
  it 'should work1' do
    arr = [0, 1, 2, nil, nil, 3]
    n0 = array_to_tree(arr)
    n0.val.must_equal(0)
    n1 = n0.left
    n1.val.must_equal(1)
    n1.left.must_equal(nil)
    n1.right.must_equal(nil)
    n2 = n0.right
    n2.val.must_equal(2)
    n3 = n2.left
    n3.val.must_equal(3)
    n2.right.must_equal(nil)
    n3.left.must_equal(nil)
    n3.right.must_equal(nil)

    arr = []
    n0 = array_to_tree(arr)
    n0.must_equal(nil)
  end
end

describe 'tree_to_array(root)' do
  it 'should work2' do
    arr = [0, 1, 2, nil, nil, 3]
    root = array_to_tree(arr)
    result = tree_to_array(root)
    result.must_equal(arr)

    arr = []
    root = array_to_tree(arr)
    result = tree_to_array(root)
    result.must_equal(arr)
  end
end
