require 'minitest/autorun'

# @param {Integer[]} nums
# @return {Integer}
def find_unsorted_subarray(nums)
  cur_max = -Float::INFINITY
  cur_max_idx = -1
  cur_min = Float::INFINITY
  cur_min_idx = -1
  from_idx = -1

  nums.each_with_index do |val, i|
    if val > cur_max
      cur_max = val
      cur_max_idx = i
    end

    if cur_max_idx != -1 && val < cur_max
      if val < cur_min
        cur_min = val
        cur_min_idx = i
      end
    end
  end

  if cur_min_idx == -1
    return 0
  end

  nums.each_with_index do |val, i|
    if val > cur_min
      from_idx = i
      break
    end
  end

  cur_max = -Float::INFINITY
  cur_max_idx = -1
  cur_min = Float::INFINITY
  cur_min_idx = -1
  to_idx = -1

  i = nums.length - 1
  while i >= 0 do
    val = nums[i]

    if val < cur_min
      cur_min = val 
      cur_min_idx = i
    end

    if cur_min_idx != -1 && val > cur_min
      if val > cur_max
        cur_max = val
        cur_max_idx = i
      end
    end
    i -= 1
  end

  i = nums.length - 1
  while i >= 0 do
    if cur_max > nums[i]
      to_idx = i
      break
    end

    i -= 1
  end

  return to_idx - from_idx + 1
end

describe 'find_unsorted_subarray(nums)' do
  it 'should work1' do
    nums = [2, 6, 4, 8, 10, 9, 15]
    expected_result = 5
    find_unsorted_subarray(nums).must_equal(expected_result)
  end

  it 'should work3' do
    1000.times do
      arr = generate_array()
      #p arr
      find_unsorted_subarray(arr).must_equal(brute_force(arr))
    end
  end

  it 'should work4' do
    arr = []
    find_unsorted_subarray(arr).must_equal(brute_force(arr))
  end
end

describe 'brute_force' do
  it 'should work2' do
    nums = [2, 6, 4, 8, 10, 9, 15]
    expected_result = 5
    brute_force(nums).must_equal(expected_result)
  end
end

def brute_force(nums)
  nums_sorted = nums.sort
  i = 0
  from_idx = -1
  to_idx = -1
  while i < nums.length do
    if nums[i] != nums_sorted[i]
      from_idx = i
      break
    end
    i += 1
  end

  if from_idx == -1
    return 0
  end

  i = nums.length - 1
  while i >= 0 do
    if nums[i] != nums_sorted[i]
      to_idx = i
      break
    end
    i -= 1
  end

  return to_idx - from_idx + 1
end

def generate_array()
  return rand(100).times.map do |i|
    rand(i)
  end
end
