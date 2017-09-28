require 'minitest/autorun'

def is_one_distance(s, t)
  if (s.length - t.length).abs > 1
    return false
  end

  if s.length == t.length
    i = 0
    cnt = 0
    while i < s.length do
      if s[i] != t[i]
        cnt += 1
        if cnt > 1
          return false
        end
      end
      i += 1
    end
    return cnt == 1
  else
    if s.length > t.length
      tmp = t
      t = s
      s = tmp
    end

    i = 0
    skipped = 0
    while i < s.length do
      if s[i] != t[i + skipped]
        skipped += 1
        if skipped > 1
          return false
        end
      end
      i += 1
    end

    return true
  end
end

describe 'is_one_distance(s, t)' do
  it 'should work1' do
    s = "abc"
    t = "abc"
    expected_result = false
    is_one_distance(s, t).must_equal(expected_result)
    is_one_distance(t, s).must_equal(expected_result)

    s = "abcde"
    t = "abc"
    expected_result = false
    is_one_distance(s, t).must_equal(expected_result)
    is_one_distance(t, s).must_equal(expected_result)

    s = "abce"
    t = "abc"
    expected_result = true
    is_one_distance(s, t).must_equal(expected_result)
    is_one_distance(t, s).must_equal(expected_result)

    s = "abec"
    t = "abc"
    expected_result = true
    is_one_distance(s, t).must_equal(expected_result)
    is_one_distance(t, s).must_equal(expected_result)

    s = "abc"
    t = "adc"
    expected_result = true
    is_one_distance(s, t).must_equal(expected_result)
    is_one_distance(t, s).must_equal(expected_result)
  end
end
