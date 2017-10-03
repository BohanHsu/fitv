require 'minitest/autorun'

# @param {Integer[]} nums
# @return {String[]}
def summary_ranges(nums)
  ranges = []
  return ranges if nums.empty?
  i = 0
  j = i + 1
  while j < nums.length do
    if nums[j] == nums[j - 1] + 1
      j += 1
    else
      ranges << [i, j - 1]
      i = j
      j = i + 1
    end
  end

  ranges << [i, j - 1]

  ranges.map! do |range|
    str = nil
    if range[0] == range[1]
      str = "#{nums[range[0]]}"
    else
      str = "#{nums[range[0]]}->#{nums[range[1]]}"
    end
    str
  end

  return ranges
end

describe 'summary_ranges(nums)' do
  it 'should work1' do
    nums = [0,1,2,4,5,7]
    expected_result = ["0->2","4->5","7"]
    summary_ranges(nums).must_equal(expected_result)

    nums = [0,2,3,4,6,8,9]
    expected_result = ["0","2->4","6","8->9"]
    summary_ranges(nums).must_equal(expected_result)
  end

  it 'should work2' do
    nums = []
    expected_result = []
    summary_ranges(nums).must_equal(expected_result)
  end
end
