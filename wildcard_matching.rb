require 'minitest/autorun'

# @param {String} s
# @param {String} p
# @return {Boolean}
def is_match(s, p)
  matrix = (s.length + 1).times.map do |i|
    (p.length + 1).times.map do |j|
      0
    end
  end

  s.length.times do |i|
    matrix[i + 1][0] = matrix[i][0] + 1
  end

  aster_show = false
  p.length.times do |j|
    #if !aster_show
    #  if p[j] == "*"
    #    aster_show = true
    #  end
    #end

    if p[j] == "*"
      matrix[0][j + 1] = matrix[0][j]
    else
      matrix[0][j + 1] = matrix[0][j] + 1
    end
  end

  s.length.times do |i|
    p.length.times do |j|
      if p[j] == "*"
        matrix[i+1][j+1] = [matrix[i][j+1], matrix[i+1][j], matrix[i][j]].min
      elsif p[j] == "?" || p[j] == s[i]
        matrix[i+1][j+1] = matrix[i][j]
      else
        # not match
        matrix[i+1][j+1] = matrix[i][j] + 1
      end
    end
  end

  return matrix[s.length][p.length] == 0
end

describe 'is_match(s, p)' do
  it 'should work1' do

    is_match("aa","a").must_equal(false)
    is_match("aa","aa").must_equal(true)
    is_match("aaa","aa").must_equal(false)
    is_match("aa", "*").must_equal(true)
    is_match("aa", "a*").must_equal(true)
    is_match("ab", "?*").must_equal(true)
    is_match("aab", "c*a*b").must_equal(false)
  end
end
