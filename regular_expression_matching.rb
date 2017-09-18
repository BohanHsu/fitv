require 'minitest/autorun'

# @param {String} s
# @param {String} p
# @return {Boolean}
def is_match(s, p)
  # s is string, p is regexp
  j = 0
  pp = []
  while j < p.length do
    if p[j] != '*'
      pp << [p[j]]
    else
      pp.last << '*'
    end
    j += 1
  end
  p = pp
  matrix = (s.length + 1).times.map do
    (p.length + 1).times.map do
      nil
    end
  end

  # i -> s
  # j -> p
  matrix[0][0] = 0
  s.length.times do |i|
    matrix[i + 1][0] = i + 1
  end

  p.length.times do |j|
    if p[j].length == 2
      matrix[0][j + 1] = matrix[0][j]
    else
      matrix[0][j + 1] = matrix[0][j] + 1
    end
  end

  s.length.times do |i|
    p.length.times do |j|
      if p[j].length == 2
        min_val = [matrix[i + 1][j], matrix[i][j] + ((p[j][0] == '.' || p[j][0] == s[i]) ? 0 : 1)].min

        #set_matrix(matrix, i + 1, j + 1, ((p[j][0] == '.' || p[j][0] == s[i]) ? 0 : 1) + min_val)
        set_matrix(matrix, i + 1, j + 1, min_val)
        if p[j][0] == '.'
          ((i + 2)..s.length).each do |k|
            set_matrix(matrix, k, j + 1, min_val)
          end
        else
          k = i + 2
          #puts "i=#{j},j=#{j}, s[k-1]=#{s[k-1]}, p[j]=#{p[j]}"
          while k <= s.length && p[j][0] == s[k - 1] do
            set_matrix(matrix, k, j + 1, min_val)
            k += 1
          end
        end

      elsif p[j][0] == '.'
        set_matrix(matrix, i + 1, j + 1, matrix[i][j])
      elsif p[j][0] == s[i]
        set_matrix(matrix, i + 1, j + 1, matrix[i][j])
      else
        set_matrix(matrix, i + 1, j + 1, matrix[i][j] + 1)
      end
    end
  end
  #matrix.each do |r|
  #  p r
  #end
  return matrix[s.length][p.length] == 0
end

def set_matrix(matrix, i, j, value)
  if matrix[i][j].nil?
    matrix[i][j] = value
  else
    matrix[i][j] = (matrix[i][j] > value ? value : matrix[i][j])
  end
end

describe 'is_match(s, p)' do
  it 'should work1' do

    s = "aa"
    p = "a"
    expected_result = false
    is_match(s, p).must_equal(expected_result)

    s = "aa"
    p = "aa"
    expected_result = true
    is_match(s, p).must_equal(expected_result)

    s = "aaa"
    p = "aa"
    expected_result = false
    is_match(s, p).must_equal(expected_result)

    s = "aa"
    p = "a*"
    expected_result = true
    is_match(s, p).must_equal(expected_result)

    s = "aa"
    p = ".*"
    expected_result = true
    is_match(s, p).must_equal(expected_result)

    s = "ab"
    p = ".*"
    expected_result = true
    is_match(s, p).must_equal(expected_result)

    s = "aab"
    p = "c*a*b"
    expected_result = true
    is_match(s, p).must_equal(expected_result)

    s = "abcd"
    p = "d*"
    expected_result = false
    is_match(s, p).must_equal(expected_result)

    s = "aaa"
    p = "ab*a"
    expected_result = false
    is_match(s, p).must_equal(expected_result)
  end

  it 'should work2' do
    s = "aaa"
    p = "ab*ac*a"
    expected_result = true
    is_match(s, p).must_equal(expected_result)
  end
end
