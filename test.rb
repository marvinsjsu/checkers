require_relative 'board'
require_relative 'piece'

if $PROGRAM_NAME == __FILE__
  board = Board.new
  board.set_pieces
  board.render
  piece = board.matrix[7][0]
  puts "Piece color: #{piece.color}"
  puts "Piece position: #{piece.pos}"
  puts "Piece get_possible_slides: #{piece.get_possible_slides}"
  puts "Piece get_possible_jumps: #{piece.get_possible_jumps}"
  piece = board.matrix[5][2]
  puts "Piece color: #{piece.color}"
  puts "Piece position: #{piece.pos}"
  puts "Piece get_possible_slides: #{piece.get_possible_slides}"
  puts "Piece get_possible_jumps: #{piece.get_possible_jumps}"
  moves = [[5, 2], [4, 1]]
  board.perform_moves!(moves, :slide)
  board.render
  piece = board.matrix[3][0]
  puts "Piece color: #{piece.color}"
  puts "Piece position: #{piece.pos}"
  puts "Piece get_possible_slides: #{piece.get_possible_slides}"
  puts "Piece get_possible_jumps: #{piece.get_possible_jumps}"
  moves = [[3, 0], [5, 2]]
  board.perform_moves!(moves, :jump)
  board.render
end