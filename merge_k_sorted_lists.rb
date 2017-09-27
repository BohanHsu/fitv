require 'minitest/autorun'

# Definition for singly-linked list.
class ListNode
    attr_accessor :val, :next
    def initialize(val)
        @val = val
        @next = nil
    end
end

# @param {ListNode[]} lists
# @return {ListNode}
def merge_k_lists(lists)
  lists = lists.select do |head|
    !head.nil?
  end

  pq = lists.sort! do |a, b|
    a.val - b.val
  end

  last_idx = lists.length - 1
  new_head = nil
  new_tail = nil
  
  #lists.each do |head|
  #  if head.nil?
  #    puts []
  #  else
  #    p list_to_array(head)
  #  end
  #end

  while last_idx >= 0 do
    cur_head = lists[0]
    if new_head.nil?
      new_head = cur_head
      new_tail = cur_head
    else
      new_tail.next = cur_head
      new_tail = cur_head
    end

    cur_next = cur_head.next
    cur_head.next = nil
    cur_head = cur_next

    lists[0] = lists[last_idx]

    i = 0
    while (i * 2 + 1 <= last_idx) && lists[i].val > lists[i * 2 + 1].val || (i * 2 + 2 <= last_idx) && lists[i].val > lists[i * 2 + 2].val do
      if (i * 2 + 2 <= last_idx) && lists[i * 2 + 2].val < lists[i * 2 + 1].val
        # swap right
        swap(lists, i, i * 2 + 2)
        i = (i * 2 + 2)
      else
        # swap left
        swap(lists, i, i * 2 + 1)
        i = (i * 2 + 1)
      end
    end

    #puts "+++++"
    #lists.each do |head|
    #  p list_to_array(head)
    #end
    #puts "+++++"

    if cur_head.nil?
      last_idx -= 1
    else
      i = last_idx
      lists[last_idx] = cur_head
      while i > 0 && lists[i].val < lists[(i - 1) / 2].val do
        swap(lists, i, (i - 1) / 2)
        i = (i - 1) / 2
      end
    end

    #puts "=====" * 5
    #p list_to_array(new_head)
    #puts '-----' * 5
    #lists.each do |head|
    #  if head.nil?
    #    puts []
    #  else
    #    p list_to_array(head)
    #  end
    #end
  end

  return new_head
end

def swap(lists, i, j)
  tmp = lists[i]
  lists[i] = lists[j]
  lists[j] = tmp
end

def list_to_array(head)
  result = []
  while !head.nil? do
    result << head.val
    head = head.next
  end
  return result
end

def array_to_list(array)
  return nil if array.empty?
  array = array.clone
  array.map! do |val|
    ListNode.new(val)
  end

  (0...(array.length - 1)).each do |i|
    array[i].next = array[i + 1]
  end

  return array[0]
end

describe 'merge_k_lists(lists)' do
  it 'should work1' do
    arrays = [
      [1,4,5,6,7,8],
      [2,6,7,9,11],
      [10,14,15,16,17,18]
    ]

    lists = arrays.map do |ar|
      array_to_list(ar)
    end

    expected_result = arrays.inject([]) do |memo, obj|
      memo + obj
    end

    expected_result.sort!

    list_to_array(merge_k_lists(lists)).must_equal(expected_result)
  end

  it 'should work2' do
    arrays = [
      [-8,-7,-7,-5,1,1,3,4],
      [-2],
      [-10,-10,-7,0,1,3],
      [2]
    ]

    lists = arrays.map do |ar|
      array_to_list(ar)
    end

    expected_result = [-10,-10,-8,-7,-7,-7,-5,-2,0,1,1,1,2,3,3,4]
    list_to_array(merge_k_lists(lists)).must_equal(expected_result)
  end
end
