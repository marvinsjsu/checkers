require 'debugger'
class Piece
  attr_accessor :pos, :color
  DIAG = {
    :red => [[-1, -1], [-1, 1]],
    :black => [[1, -1], [1, 1]]
  }

  SYM = {
    :black => "",
    :red => ""
  }

  def initialize(board, pos, color)
    @board, @pos, @color = board, pos, color
    @board.add_piece(self, pos)
    @kinged = false
  end

  def possible_moves
    get_possible_slides + get_possible_jumps
  end

  def get_possible_slides
    slides = []
    x, y = @pos
    move_diffs.each do |move|
      new_x = x + move[0]
      new_y = y + move[1]
      slides << [new_x, new_y] if @board.valid_pos?([new_x, new_y])
    end
    slides
  end

  def get_possible_jumps
    jumps = []
    x, y = @pos
    move_diffs.each do |move|
      new_x = x + move[0]
      new_y = y + move[1]
      if @board.can_jump_over?([new_x, new_y], @color)
        new_x = x + (2 * move[0])
        new_y = y + (2 * move[1])
        jumps << [new_x, new_y] if @board.valid_pos?([new_x, new_y])
      end
    end
    jumps
  end

  def perform_slide(to_pos)
    move_sequence = [pos]
    move_sequence << to_pos
    simulation = @board.dup
   #  @board.perform_move()if simulation.perform_move(move_sequence)
  end

  def perform_jump(from_pos, to_pos)
    x, y = from_pos
    new_x, new_y = to_pos
    jumped_x = (new_x + x) / 2
    jumped_y = (new_y + y) / 2
    @board.turn_nil([x, y])
    @board.turn_nil([jumped_x, jumped_y])
    @board.add_piece(self, [new_x, new_y])
    self.pos = [new_x, new_y]
    true
  end

  def move_diffs
    DIAG[@color]
  end

  def to_s

  end
end