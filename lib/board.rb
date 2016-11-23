class Board
  def initialize
    @board = [
      ['_', '_', '_', '_'],
      ['_', '_', '_', '_'],
      ['_', '_', '_', '_'],
      ['_', '_', '_', '_'],
    ]
  end

  def setup(fen='0/0/0/0')
    row_num=3
    fen.split('/').each do |row|
      col_num=0
      row.chars.each do |c|
        if ['1', '2', '3', '4'].include?(c)
          col_num += c.to_i
        else
          @board[row_num][col_num] = c
          col_num += 1
        end
      end
      row_num -= 1
    end
  end

  def to_fen
    rows = []
    3.downto(0).each do |row_num|
      row=''
      spaces=0
      space_flag=0
      (0..3).each do |col_num|
        square = @board[row_num][col_num]
        if square == '_'
          spaces+=1
          space_flag=1
        else
          if space_flag == 1
            row += spaces.to_s
          end
          space_flag=0
          spaces=0
          row += square
        end
      end
      if space_flag == 1
        row += spaces.to_s
        space_flag=0
      end
      rows << row
    end

    rows.join('/')
  end

  def to_s
    output=''
    3.downto(0).each do |row_num|
      output += "#{row_num+1}|"
      (0..3).each do |col_num|
        output += "#{@board[row_num][col_num]}|"
      end
      output += "\n"
    end
    output += "  a b c d"
  end

  def square_row_col(row, col)
    @board[row][col]
  end

  def algebraic_to_row_col(algebraic)
    col = algebraic[0].ord - 97
    row = algebraic[1].to_i - 1
    [row, col]
  end

  def square_algebraic(algebraic)
    row, col = algebraic_to_row_col(algebraic)
    square_row_col(row, col)
  end

  def row_col_to_algebraic(row, col)
    (97 + col).chr + (row + 1).to_s
  end

  def move!(from_to_algebraic)
    from_algebraic, to_algebraic = from_to_algebraic.split('-')
    from_row, from_col = algebraic_to_row_col(from_algebraic)
    to_row, to_col = algebraic_to_row_col(to_algebraic)
    @board[to_row][to_col] = @board[from_row][from_col]
    @board[from_row][from_col] = '_'
  end

  def is_valid_board_row_col?(row, col)
    log = Logger.new($stderr)
    log.level = Logger::INFO

    result = true
    result = false if col < 0 || col > 3
    result = false if row < 0 || row > 3

    log.debug("is_valid_board_row_col?(#{row}, #{col}) = #{result}")
    result
  end
end
