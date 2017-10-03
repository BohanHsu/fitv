require 'minitest/autorun'

# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer}
def find_kth_largest(nums, k)
  return helper(nums, k, 0, nums.length, 0)
end

def helper(nums, k, from, to, q)
  #return if q > 5
  #puts "helper(from=#{from}, to=#{to}, nums=#{nums})"
  pivot = rand(to - from)
  #pivot = to - 1
  #puts "pivot=#{nums[pivot + from]}, "
  swap(nums, from, from + pivot)

  i = from + 1
  j = from
  while i < to do
    #puts "nums[i] = #{nums[i]}"
    if nums[i] > nums[from]
      j += 1
      swap(nums, i, j)
    end
    i += 1
  end

  #puts "nums=#{nums}"
  swap(nums, j, from)
  #puts "nums=#{nums}"
  #puts "j=#{j}"

  if j == k - 1
    return nums[j]
  end

  if j < k - 1
    return helper(nums, k, j + 1, to, q + 1)
  end

  if j > k - 1
    return helper(nums, k, from, j, q + 1)
  end
end

def swap(nums, i, j)
  tmp = nums[i]
  nums[i] = nums[j]
  nums[j] = tmp
end

describe 'find_kth_largest(nums, k)' do
  it 'should work1' do
    nums = [3,2,1,5,6,4]
    k = 2
    expected_result = 5
    find_kth_largest(nums, k).must_equal(expected_result)
  end

  it 'should work3' do

    nums=[8, 8, 2, 0, 1, 17, 5, 2, 0, 3, 4, 3, 14, 0, 8, 25, 3, 5, 0, 0, 4, 6, 18, 6, 11, 1, 8, 0, 3, 12, 7, 3, 6] 
    k=5

    expected_result = nums.sort.reverse[k - 1]
    find_kth_largest(nums, k).must_equal(expected_result)
  end

  it 'should work2' do
    10000.times.map do |i|
      nums = rand(1000).times.map do |j|
        rand(j).to_i
      end.shuffle
      k = rand(nums.length).to_i + 1

      #puts "nums=#{nums}, k=#{k}"
      result = find_kth_largest(nums, k)
      expected_result = nums.sort.reverse[k - 1]
      result.must_equal(expected_result)
    end
  end
end
