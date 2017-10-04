require 'minitest/autorun'

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def search(nums, target)
  return helper(nums, target, 0, nums.length)
end

def helper(nums, target, from, to)
  #puts "helper(from=#{from}, to=#{to})"
  if to - from == 0
    if nums[from] == target
      return from
    else
      return -1
    end
  end

  if to - from == 1
    if nums[from] == target
      return from
    elsif nums[to] == target
      return to
    else
      return -1
    end
  end

  i = (from + to) / 2
  #puts "i=#{i}"
  if nums[i] == target
    return i
  end

  if nums[from] < nums[i]
    # this part is sorted
    if nums[from] <= target && target <= nums[i-1]
      return helper(nums, target, from, i)
    else
      return helper(nums, target, i, to)
    end

  else
    #nums[i] <= nums[to - 1]
    if nums[i] <= target && target <= nums[to-1]
      return helper(nums, target, i, to)
    else
      return helper(nums, target, from, i)
    end
  end
end

describe 'search(nums, target)' do
  it 'should work1' do
    nums = [4, 5, 6, 7, 0, 1, 2]
    target = 6
    expected_result = nums.find_index(target)
    expected_result = expected_result.nil? ? -1 : expected_result
    search(nums, target).must_equal(expected_result)

    nums = [4, 5, 6, 7, 0, 1, 2]
    target = 1
    expected_result = nums.find_index(target)
    expected_result = expected_result.nil? ? -1 : expected_result
    search(nums, target).must_equal(expected_result)

    nums = [4, 5, 6, 7, 0, 1, 2]
    target = 11
    expected_result = nums.find_index(target)
    expected_result = expected_result.nil? ? -1 : expected_result
    search(nums, target).must_equal(expected_result)
  end

  it 'should work2' do
    nums = [7,8,1,2,3,4,5,6]
    target = 2
    expected_result = nums.find_index(target)
    expected_result = expected_result.nil? ? -1 : expected_result
    search(nums, target).must_equal(expected_result)
  end
end
