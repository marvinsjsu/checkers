class Board
  attr_reader :matrix
  def initialize(filled_board = true)
    build_matrix(filled_board)
  end

  def build_matrix(board)
    @matrix = Array.new(8) { Array.new(8) { nil }}
  end

  def set_pieces
    (0..7).each do |row|
      (0..7).each do |col|
        if row > 4
          if (row.even? && col.odd?) || (row.odd? && col.even?)
            create_piece(:red, [row, col])
          end
        elsif row < 4
          if (row.even? && col.odd?) || (row.odd? && col.even?)
            create_piece(:black, [row, col])
          end
        end
      end
    end
  end

  def dup
    copy = Board.new
    (0..7).each do |row|
      (0..7).each do |col|
        piece = @matrix[row][col]
        unless piece.nil?
          new_piece = piece.class.new(copy, piece.pos, piece.color)
          copy.add_piece(new_piece)
        end
      end
    end
    copy
  end

  def create_piece(color, pos)
    piece = Piece.new(self, pos, color)
  end

  def add_piece(piece, pos)
    x, y = pos
    @matrix[x][y] = piece
  end

  def turn_nil(pos)
    x, y = pos
    @matrix[x][y] = nil
  end

  def perform_moves(move_sequence)
    curr_pos = move_sequence.shift
    x, y = curr_pos
    piece = @matrix[x][y]
    possible_moves = piece.possible_moves
    move_sequence.each do |move|
      return false unless possible_moves.include?(move)
    end
    true
  end

  def valid_move_seq?

  end

  def perform_moves!(move_sequence, type)
    # debugger
    curr_pos = move_sequence.shift
    x, y = curr_pos
    piece = @matrix[x][y]
    move_sequence.each do |move|
      piece.perform_jump(curr_pos, move) if type == :jump
      # new_x, new_y = move
      # @matrix[x][y] = nil
      # @matrix[new_x][new_y] = piece
      # piece.pos = [new_x, new_y]
    end
  end

  def maybe_promote

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
    puts "============================="
    puts ""
    (0..7).each do |row|
      print "pos: #{row} ::  "
      (0..7).each do |col|
        piece = @matrix[row][col]
        print (piece.nil? ? "[ ]" : "[O]")
      end
      puts ""
    end
  end
end