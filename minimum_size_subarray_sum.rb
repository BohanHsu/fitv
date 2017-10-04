require 'minitest/autorun'

# @param {Integer} s
# @param {Integer[]} nums
# @return {Integer}
def min_sub_array_len(s, nums)
  return 0 if nums.empty?

  cur_sum = 0
  min_i = nums.length
  min_j = -1

  i = 0
  j = 0

  while i < nums.length do
    while cur_sum < s && i < nums.length do
      cur_sum += nums[i]
      i += 1
    end

    while cur_sum >= s && j < i do
      #puts "i=#{i}, j=#{j}"
      if i - j < min_i - min_j
        min_i = i
        min_j = j
      end

      cur_sum -= nums[j]
      j += 1
    end
  end

  #return nums[min_j..min_i]
  #puts "min_i=#{min_i}, min_j=#{min_j}"
  if min_j == -1
    return 0
  end
  return min_i - min_j
end

describe 'min_sub_array_len(s, nums)' do
  it 'should work1' do
    nums = [2,3,1,2,4,3]
    s = 7
    expected_result = 2

    min_sub_array_len(s, nums).must_equal(expected_result)
  end

  it 'should work2' do
    nums = [1,1]
    s = 7
    expected_result = 0

    min_sub_array_len(s, nums).must_equal(expected_result)
  end
end
