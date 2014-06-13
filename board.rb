require 'colorize'

class Board
  attr_reader :matrix
  def initialize
    build_matrix
  end

  def build_matrix
    @matrix = Array.new(8) { Array.new(8) { nil }}
  end

  def set_pieces
    (0..7).each do |row|
      (0..7).each do |col|
        if row > 4
          if (row.even? && col.odd?) || (row.odd? && col.even?)
            create_piece(:red, [row, col])
          end
        elsif row < 3
          if (row.even? && col.odd?) || (row.odd? && col.even?)
            create_piece(:black, [row, col])
          end
        end
      end
    end
  end

  def create_piece(color, pos)
    piece = Piece.new(self, pos, color)
  end

  def add_piece(piece, pos)
    x, y = pos
    @matrix[x][y] = piece
  end

  def get_piece(pos)
    x, y = pos
    @matrix[x][y]
  end

  def turn_nil(pos)
    x, y = pos
    @matrix[x][y] = nil
  end

  def remove_piece(pos)
    x, y = pos
    piece = @matrix[x][y]
    @matrix[x][y] = nil
  end

  def dup
    copy = Board.new
    (0..7).each do |row|
      (0..7).each do |col|
        piece = @matrix[row][col]
        unless piece.nil?
          new_piece = piece.class.new(copy, piece.pos, piece.color)
          copy.add_piece(new_piece, [row, col])
        end
      end
    end
    copy
  end

  def won?(color)
    pieces = @matrix.flatten.compact.select { |piece| piece.color == color }
    pieces.empty?
  end

  def perform_moves(move_sequence)
    copy_board = self.dup
    copy_sequence = move_sequence.dup
    copy_board.perform_moves!(copy_sequence)
  end

  def perform_moves!(move_sequence)
    curr_pos = move_sequence.shift
    x, y = curr_pos

    piece = @matrix[x][y]
    raise "Error: there is no checker piece at #{curr_pos}" if piece.nil?

    valid = true

    move_sequence.each do |move|
      new_x, new_y = move
      jump = (-1..1).include?(new_x - x)
      valid = jump ? piece.perform_slide(curr_pos, move) : piece.perform_jump(curr_pos, move)

      return false if !valid
    end

    maybe_promote
    true
  end

  def maybe_promote
    red_pieces = get_all_pieces(:red)
    black_pieces = get_all_pieces(:black)
    red_pieces.map! { |piece| piece.kinged = true if piece.pos[0] == 0 }
    black_pieces.map! { |piece| piece.kinged = true if piece.pos[0] == 7 }
  end

  def get_all_pieces(color)
    pieces = @matrix.flatten.compact.select { |piece| piece.color == color }
  end

  def can_jump_over?(pos, color)
    x, y = pos
    piece = @matrix[x][y]
    return false if piece.nil?
    piece.color != color
  end

  def valid_pos?(pos)
    x, y = pos
    in_bounds?(pos) && @matrix[x][y] == nil
  end

  def in_bounds?(pos)
    x, y = pos
    (0..7).include?(x) && (0..7).include?(y)
  end

  def render
    puts ""
    puts ""
    puts "         0   1   2   3   4   5   6   7 "
    puts "---------------------------------------"
    (0..7).each do |row|
      print "ROW #{row}  "
      (0..7).each do |col|
        piece = @matrix[row][col]
        empty_box = "    "
        occupied = " #{piece.to_s}  "
        str = piece.nil? ? empty_box : occupied

        if (row.odd? && col.even?) || (row.even? && col.odd?)
          print str.colorize(:color => :white).colorize(:background =>  :red)
        else
          print str.colorize(:color => :red).colorize(:background => :light_white)
        end
      end
      puts ""
    end
  end

  def add_color(str, row, col)
    debugger

    str
  end

end