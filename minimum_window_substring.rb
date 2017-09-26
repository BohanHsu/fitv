require 'minitest/autorun'

# @param {String} s
# @param {String} t
# @return {String}
def min_window(s, t)
  map_t = {}
  t.chars.each do |chr|
    if !map_t.has_key?(chr)
      map_t[chr] = 0
    end
    map_t[chr] += 1
  end
  min_i = s.length
  min_j = 0

  setted = false
  i = 0
  j = 0

  map_missing = map_t.clone
  map_s = {}

  while i < s.length do
    while map_missing.size > 0 && i < s.length do
      chr = s[i]
      if map_t.has_key?(chr)
        if map_missing.has_key?(chr)
          map_missing[chr] -= 1
        end

        if map_missing[chr] == 0
          map_missing.delete(chr)
        end

        if !map_s.has_key?(chr)
          map_s[chr] = 0
        end
        map_s[chr] += 1
      end

      i += 1
    end
    #puts "i=#{i}"
    #puts "map_missing=#{map_missing}"
    #puts "map_s=#{map_s}"

    while j < i && map_missing.size == 0 do
      chr = s[j]
      if map_t.has_key?(chr)
        if map_s[chr] == map_t[chr]
          # is this a minimun sub string?
          if i - j <= min_i - min_j
            min_i = i
            min_j = j
            setted = true
          end
        end
        map_s[chr] -= 1
        if map_s[chr] < map_t[chr]
          if !map_missing.has_key?(chr)
            map_missing[chr] = 0
          end
          map_missing[chr] += 1
        end
      end
      j += 1
    end
    #puts "j=#{j}"
    #puts ""
  end

  #puts "missing:#{map_missing}"
  #puts "setted=#{setted}"
  #puts "j=#{min_j}, i=#{min_i}"
  return setted ? s[min_j...min_i] : ""
end

describe 'min_window(s, t)' do
  it 'should work1' do
    s = "ADOBECODEBANC"
    t = "ABC"
    expected_result = "BANC"
    min_window(s, t).must_equal(expected_result)

    s = "a"
    t = "aa"
    expected_result = ""
    min_window(s, t).must_equal(expected_result)
  end

  it 'should work2' do
    s = "a"
    t = "a"
    expected_result = "a"
    min_window(s, t).must_equal(expected_result)
  end
end
