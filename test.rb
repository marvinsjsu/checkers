require_relative 'board'
require_relative 'piece'

if $PROGRAM_NAME == __FILE__
  board = Board.new
  board.set_pieces
  board.render
  moves = [[5, 2], [4, 1]]
  board.perform_moves!(moves) if board.perform_moves(moves)
  board.render
  moves = [[2, 1], [3, 0]]
  board.perform_moves!(moves) if board.perform_moves(moves)
  board.render
  moves = [[5, 4], [4, 3]]
  board.perform_moves!(moves) if board.perform_moves(moves)
  board.render
  moves = [[3, 0], [5, 2]]
  board.perform_moves!(moves) if board.perform_moves(moves)
  board.render

  # option = user_prompt(options)
  # case option
  # when "s"
  #   save
  # when "q"
  #   system("clear")
  #   break
  # end

  # options = "Options: (s) - save (q) - quit  (p) - play: "
end