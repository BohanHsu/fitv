require 'minitest/autorun'

# @param {Character[][]} board
# @param {String} word
# @return {Boolean}
def exist(board, word)
  height = board.length
  width = board[0].length

  mask = board.map do
    board[0].length.times.map do
      false
    end
  end

  height.times do |i|
    width.times do |j|
      #set_mask(mask, i, j, true)
      tmp = helper(board, word, 0, mask, i, j)
      if tmp
        return true
      end
      #set_mask(mask, i, j, false)
    end
  end
  return false
end

def helper(board, word, from, mask, i, j)
  #puts "helper(#{from}, #{i}, #{j})"
  #mask.each do |row|
  #  p row
  #end
  if i < 0 || i >= board.length || j < 0 || j >= board[0].length
    #puts "maozi 1"
    return false
  end

  if mask[i][j]
    #puts "maozi 2"
    return false
  end

  if board[i][j] != word[from]
    #puts "maozi 3"
    return false
  end

  if from == word.length - 1
    return true
  end

  set_mask(mask, i, j, true)
  tmp = (helper(board, word, from + 1, mask, i - 1, j) || helper(board, word, from + 1, mask, i + 1, j)|| helper(board, word, from + 1, mask, i, j - 1)|| helper(board, word, from + 1, mask, i, j + 1))

  set_mask(mask, i, j, false)

  ##set_mask(mask, i - 1, j, true)
  #tmp = helper(board, word, from + 1, mask, i - 1, j)
  #if tmp
  #  return true
  #end
  ##set_mask(mask, i - 1, j, false)

  ##set_mask(mask, i + 1, j, true)
  #tmp = helper(board, word, from + 1, mask, i + 1, j)
  #if tmp
  #  return true
  #end
  ##set_mask(mask, i + 1, j, false)

  ##set_mask(mask, i, j - 1, true)
  #tmp = helper(board, word, from + 1, mask, i, j - 1)
  #if tmp
  #  return true
  #end
  ##set_mask(mask, i, j - 1, false)

  ##set_mask(mask, i, j + 1, true)
  #tmp = helper(board, word, from + 1, mask, i, j + 1)
  #if tmp
  #  return true
  #end
  ##set_mask(mask, i, j + 1, false)

  return tmp
end

def set_mask(mask, i, j, value)
  if i < 0 || i > mask.length || j < 0 || j > mask[0].length
    return
  end
  mask[i][j] = value
end

describe '' do
  it '' do
    board = [
      ['A','B','C','E'],
      ['S','F','C','S'],
      ['A','D','E','E']
    ]
    word = "ABCCED"
    expected_result = true
    exist(board, word).must_equal(expected_result)

    word = "SEE"
    expected_result = true
    exist(board, word).must_equal(expected_result)

    word = "ABCB"
    expected_result = false
    exist(board, word).must_equal(expected_result)
  end
end
