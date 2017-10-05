require 'minitest/autorun'

# @param {String} s
# @return {String[]}
def remove_invalid_parentheses(s)
  total_paris = 0
  map = {}

  stack = []
  s.chars.each_with_index do |chr, i|
    if chr == "("
      stack << i
    elsif chr == ")"
      if !stack.empty? && s[stack.last] == "("
        stack.pop
        total_paris += 1
      end
    end
  end

  remove_helper(s, 0, "", 0, 0, total_paris, map)
  result = map.keys
  if result.empty?
    result << ""
  end
  #puts "result=#{result}"
  return  result
end

def remove_helper(s, from, cur_str, count_open, cur_pairs, total_paris, result)
  if from == s.length
    if cur_pairs == total_paris && count_open == 0
      result[cur_str] = nil
    end
    return
  end

  if s[from] == "("
    remove_helper(s, from + 1, cur_str + "(", count_open + 1, cur_pairs, total_paris, result)
    remove_helper(s, from + 1, cur_str, count_open, cur_pairs, total_paris, result)
  elsif s[from] == ")"
    if count_open > 0
      remove_helper(s, from + 1, cur_str + ")", count_open - 1, cur_pairs + 1, total_paris, result)
    end

    remove_helper(s, from + 1, cur_str, count_open, cur_pairs, total_paris, result)
  else

    remove_helper(s, from + 1, cur_str + s[from], count_open, cur_pairs, total_paris, result)
  end
end

describe 'remove_invalid_parentheses(s)' do
  it '' do
    s = "()())()"
    expected_result = ["()()()", "(())()"]
    remove_invalid_parentheses(s).sort.must_equal(expected_result.sort)

    s = "(a)())()"
    expected_result = ["(a)()()", "(a())()"]
    remove_invalid_parentheses(s).sort.must_equal(expected_result.sort)

    s = ")("
    expected_result = [""]
    remove_invalid_parentheses(s).sort.must_equal(expected_result.sort)
  end
end

