require 'minitest/autorun'

# @param {Integer[]} candidates
# @param {Integer} target
# @return {Integer[][]}
def combination_sum(candidates, target)
  candidates.sort!
  cache = {}

  return combination_helper(candidates, 0, target, cache)
end

def combination_helper(candidates, from, target, cache)
  if cache.has_key?(from) && cache[from].has_key?(target)
    return cache[from][target]
  end
  #puts "target=#{from}, #{target}"
  result = []
  result_hash = {}

  if target == 0
    return [[]]
  end

  (from...(candidates.length)).each do |i|
    val = candidates[i]
    if target - val >= 0
      #puts "calling: i=#{i}, target=#{(target - val)}"
      suffixs = combination_helper(candidates, i, (target - val), cache)
      suffixs.each do |suffix|
        temp = [val] + suffix
        key = temp.join(",")
        if !result_hash.has_key?(key)
          result << temp
          result_hash[key] = nil
        end
      end
    end
  end

  if !cache.has_key?(from)
    cache[from] = {}
  end

  cache[from][target] = result

  return result
end

describe 'combination_sum(candidates, target)' do
  it 'should work1' do
    candidates = [2, 3, 6, 7]
    target = 7
    expected_result = [
      [7],
      [2, 2, 3]
    ]
    combination_sum(candidates, target).sort.must_equal(expected_result.sort)
  end
end
