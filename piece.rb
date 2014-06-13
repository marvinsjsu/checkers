require 'debugger'
class Piece
  attr_accessor :pos, :color
  DIAG = {
    :red => [[-1, -1], [-1, 1]],
    :black => [[1, -1], [1, 1]],
    :kinged => [[1, -1], [1, 1], [-1, -1], [-1, 1]]
  }

  SYM = {
    :black => "\u26AB",
    :red => "\u26D4"
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

  def perform_slide(from_pos, to_pos)
    new_x, new_y = to_pos
    raise "Not a valid move." unless possible_moves.include?(to_pos)
    @board.turn_nil(from_pos)
    @board.add_piece(self, to_pos)
    self.pos = [new_x, new_y]
    true
  end

  def perform_jump(from_pos, to_pos)
    x, y = from_pos
    new_x, new_y = to_pos
    raise "Not a valid move." unless possible_moves.include?(to_pos)
    jumped_x = (new_x + x) / 2
    jumped_y = (new_y + y) / 2

    @board.turn_nil([x, y])
    @board.turn_nil([jumped_x, jumped_y])
    @board.add_piece(self, [new_x, new_y])
    self.pos = [new_x, new_y]
    true
  end

  def promote
    @kinged = true
  end

  def move_diffs
    @kinged ? DIAG[:kinged] : DIAG[@color]
  end

  def to_s
    SYM[@color.to_sym]
  end
end