require 'logger'

class Player
  MAX_DISTANCE=3

  NON_KNIGHT_PIECE_OFFSETS_AND_MAX_DISTANCE = {
      'p' => [
          [+1, -1, 1],
          [+1, +1, 1],
      ],
      'b' => [
          [+1, -1, MAX_DISTANCE],
          [+1, +1, MAX_DISTANCE],
          [-1, -1, MAX_DISTANCE],
          [-1, +1, MAX_DISTANCE],
      ],
      'r' => [
          [+1, 0, MAX_DISTANCE],
          [0, +1, MAX_DISTANCE],
          [-1, 0, MAX_DISTANCE],
          [0, -1, MAX_DISTANCE],
      ],
      'q' => [
          [+1, -1, MAX_DISTANCE],
          [+1, +1, MAX_DISTANCE],
          [-1, -1, MAX_DISTANCE],
          [-1, +1, MAX_DISTANCE],
          [+1, 0, MAX_DISTANCE],
          [0, +1, MAX_DISTANCE],
          [-1, 0, MAX_DISTANCE],
          [0, -1, MAX_DISTANCE],
      ],
      'k' => [
          [+1, -1, 1],
          [+1, +1, 1],
          [-1, -1, 1],
          [-1, +1, 1],
          [+1, 0, 1],
          [0, +1, 1],
          [-1, 0, 1],
          [0, -1, 1],
      ],
  }

  def find_pieces(board)
    pieces=[]

    3.downto(0).each do |row_num|
      (0..3).each do |col_num|
        square = board.square_row_col(row_num, col_num)
        if square != '_'
          pieces << board.row_col_to_algebraic(row_num, col_num)
        end
      end
    end

    pieces.sort
  end

  def find_captures_for_offsets(board, algebraic, offsets)
    log = Logger.new($stderr)
    log.level = Logger::INFO

    captures = []
    row, col = board.algebraic_to_row_col(algebraic)
    log.debug("find_captures_for_offsets: algebraic=<#{algebraic}>, row=<#{row}>, col=<#{col}>")
    log.debug("find_captures_for_offsets: offsets=<#{offsets.inspect}>")

    offsets.each_slice(2) do |row_offset, col_offset|
      # log.debug("find_captures_for_offsetsrow_offset=<#{row_offset}>, col_offset=<#{col_offset}>")
      if board.is_valid_board_row_col?(row+row_offset, col+col_offset)
        target_algebraic=board.row_col_to_algebraic(row+row_offset, col+col_offset)
        log.debug("find_captures_for_offsets: board.square_algebraic(#{algebraic})=<#{board.square_algebraic(algebraic)}>")

        if board.square_algebraic(target_algebraic) != '_'
          captures << "#{algebraic}-#{target_algebraic}"
          log.debug("find_captures_for_offsets: captures=<#{captures.inspect}>")
        end
      end
    end

    captures
  end

  def find_offsets_for_direction(board, algebraic, row_inc, col_inc, max_distance)
    log = Logger.new($stderr)
    log.level = Logger::INFO

    offsets = []
    row, col = board.algebraic_to_row_col(algebraic)
    (1..max_distance).each do |distance|
      target_offset_row=row_inc * distance
      target_row=row + target_offset_row
      target_offset_col=col_inc * distance
      target_col=col +target_offset_col

      if board.is_valid_board_row_col?(target_row, target_col)
        log.debug("#{algebraic} at #{distance} -> #{board.row_col_to_algebraic(target_row, target_col)}")
        target_square = board.square_row_col(target_row, target_col)
        if target_square != '_'
          offsets << [target_offset_row, target_offset_col]
          break
        end
      else
        break
      end
    end
    log.debug("find_offsets_for_direction: #{offsets.inspect}")
    offsets
  end

  def find_offsets_for_piece(board, algebraic, piece)
    log = Logger.new($stderr)
    log.level = Logger::INFO

    offsets = []

    if piece == 'n'
      offsets = [
          [+2, +1], [+1, +2], [+2, -1], [+1, -2], [-2, +1], [-1, +2], [-2, -1], [-1, -2]
      ]
    else
      NON_KNIGHT_PIECE_OFFSETS_AND_MAX_DISTANCE[piece].each do |row_inc, col_inc, max_distance|
        log.debug("row_inc=<#{row_inc}>, col_inc=<#{col_inc}>, max_distance=<#{max_distance}>")
        offsets << find_offsets_for_direction(board, algebraic, row_inc, col_inc, max_distance)
      end
    end

    offsets
  end

  def find_captures_for_piece(board, algebraic, piece)
    log = Logger.new($stderr)
    log.level = Logger::INFO

    captures = []
    offsets = []

    offsets << find_offsets_for_piece(board, algebraic, piece)
    offsets.flatten!
    log.debug("find_captures_for_piece: offsets=<#{offsets.inspect}>")

    captures << find_captures_for_offsets(board, algebraic, offsets)
    captures.flatten!.sort!
    log.debug("find_captures_for_piece: captures=<#{captures.inspect}>")

    captures
  end

  def find_captures(board)
    log = Logger.new($stderr)
    log.level = Logger::INFO

    captures = []

    piece_algebraic_coordinates = find_pieces(board)
    log.debug("find_captures: piece_algebraic_coordinates=<#{piece_algebraic_coordinates}>")

    piece_algebraic_coordinates.each do |algebraic|
      log.debug("find_captures: algebraic=<#{algebraic}>")
      piece = board.square_algebraic(algebraic)
      log.debug("find_captures: piece=<#{piece}>")

      captures << find_captures_for_piece(board, algebraic, piece)
      log.debug("find_captures: captures=<#{captures.inspect}>")
    end

    captures.flatten!
    captures.sort
  end
end
