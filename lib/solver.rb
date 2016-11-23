require_relative 'board'
require_relative 'player'

require 'logger'

class Solver
  def find_solution(board, path='')
    log = Logger.new($stderr)
    log.level = Logger::INFO

    player = Player.new
    captures = player.find_captures(board)
    pieces = player.find_pieces(board)

    if captures.size.zero? && pieces.size == 1
      return path
    else
      solutions = ''
      captures.each do |capture|
        new_board=Board.new
        new_board.setup(board.to_fen)
        new_board.move!(capture)
        new_path=path
        new_path+=' ' if path != ''
        new_path+=capture
        solution=find_solution(new_board, "#{new_path}")
        if solutions == ''
          solutions = solution
        else
          solutions += ", #{solution}" if solution != ''
        end
      end
    end

    log.debug("solutions=<#{solutions.inspect}>")
    return solutions
  end
end
