require 'minitest/autorun'

# @param {Integer[]} candidates
# @param {Integer} target
# @return {Integer[][]}
def combination_sum2(candidates, target)
  candidates.sort!

  #if candidates.length == 1
  #  if target == candidates[0]
  #    return [[target]]
  #  else
  #    return []
  #  end
  #end

  return combination_helper(0, candidates, target)
end

def combination_helper(from, candidates, target)
  #puts "combination_helper(#{from}, #{candidates}, #{target})"
  result_hash = {}
  result = []

  if target == 0
    return [[]]
  end

  if target < 0
    return []
  end

  if from >= candidates.length
    return []
  end

  (from...(candidates.length)).each do |i|
    val = candidates[i]

    suffixs = combination_helper(i + 1, candidates, target - val)
    suffixs.each do |suffix|
      temp = [val] + suffix
      key = temp.join(',')
      if !result_hash.has_key?(key)
        result_hash[key] = nil
        result << temp
      end
    end
  end

  return result
end

describe 'combination_sum2(candidates, target)' do
  it 'should work1' do
    candidates = [10, 1, 2, 7, 6, 1, 5]
    target = 8

    expected_result = [
      [1, 7],
      [1, 2, 5],
      [2, 6],
      [1, 1, 6]
    ]
    combination_sum2(candidates, target).sort.must_equal(expected_result.sort)

    candidates = [1]
    target = 1
    expected_result = [[1]]
    combination_sum2(candidates, target).sort.must_equal(expected_result.sort)
  end

  it 'should work2' do
    candidates = [1, 1]
    target = 2
    expected_result = [[1, 1]]
    combination_sum2(candidates, target).sort.must_equal(expected_result.sort)
  end
end
