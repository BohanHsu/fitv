require 'minitest/autorun'

# @param {String[]} strs
# @return {String[][]}
def group_anagrams(strs)
  map = {}
  strs.each do |str|
    key = get_key(str)
    if !map.has_key?(key)
      map[key] = []
    end
    map[key] << str
  end

  result = map.values
  return result
end

def get_key(str)
  return str.chars.sort.join('')
end

describe 'group_anagrams(strs)' do
  it 'should work1' do
    strs = ["eat", "tea", "tan", "ate", "nat", "bat"]
    result = group_anagrams(strs)
    expected_result = [
      ["ate", "eat","tea"],
      ["nat","tan"],
      ["bat"]
    ]
    expected_result.each do |row|
      row.sort!
    end
    expected_result.sort!
    result.each do |row|
      row.sort!
    end
    result.sort!
    result.must_equal(expected_result)
  end
end
