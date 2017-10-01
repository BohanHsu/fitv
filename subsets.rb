require 'minitest/autorun'

# @param {Integer[]} nums
# @return {Integer[][]}
def subsets(nums)
  nums.sort!

  return subsets_helper(nums)
end

def subsets_helper(nums)
  #puts "helper:#{nums}"
  result = []
  result_hash = {}

  if nums.length == 0
    return []
  end

  if nums.length == 1
    return [[], nums.clone]
  end

  if nums.length >= 2
    sub_subsets = subsets_helper(nums[1...nums.length])

    sub_subsets.each do |sub_subset|
      temp = sub_subset + []
      key = temp.join(',')
      if !result_hash.has_key?(key)
        result << temp
        result_hash[key] = nil
      end

      temp = [nums[0]] + sub_subset
      key = temp.join(',')
      if !result_hash.has_key?(key)
        result << temp
        result_hash[key] = nil
      end
    end
  end

  return result
end

describe 'subsets(nums)' do
  it 'should work1' do
    nums = [1,2,3]
    expected_result = [
      [3],
      [1],
      [2],
      [1,2,3],
      [1,3],
      [2,3],
      [1,2],
      []
    ]
    subsets(nums).sort.must_equal(expected_result.sort)
  end
end
