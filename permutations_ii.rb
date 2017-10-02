require 'minitest/autorun'

# @param {Integer[]} nums
# @return {Integer[][]}
def permute_unique(nums)
  nums.sort!
  used = nums.map do
    false
  end
  result = []
  cur_result = []

  helper(result, nums, cur_result, used)

  return result
end

def helper(result, nums, cur_result, used)
  #puts "helper(#{result}, #{nums}, #{cur_result}, #{used})"
  if cur_result.length == nums.length
    result << cur_result.clone
  end

  nums.each_with_index do |val, i|
    #puts "  val=#{val}, i=#{i}, cur_result=#{cur_result}, used=#{used}"
    if used[i]
      next
    end

    if i > 0 && nums[i - 1] == nums[i] && !used[i - 1]
      next
    end

    cur_result << val
    used[i] = true

    helper(result, nums, cur_result, used)

    cur_result.pop
    used[i] = false
  end
  #puts "helper end"
end

describe 'permute_unique(nums)' do
  it 'should work1' do
    nums = [1,1,2]
    expected_result = [
      [1,1,2],
      [1,2,1],
      [2,1,1]
    ]
    permute_unique(nums).sort.must_equal(expected_result.sort)
  end
end
