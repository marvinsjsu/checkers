require_relative 'board'
require_relative 'piece'
require_relative 'player'

class Game
  def initialize(player1, player2)
    @board = Board.new
    @board.build_matrix
    @board.set_pieces
    @players= [player1, player2]
  end

  def play
    system("clear")
    puts "Welcome to Checkers"
    puts "Player 1 = #{@players[0].name} and has #{@players[0].color}"
    puts "Player 2 = #{@players[1].name} and has #{@players[1].color}"

    i = 0
    until won?(:red) || won?(:black)
      player = i.odd? ? @players[0] : @players[1]
      @board.render
      begin
        move = player.get_input
        @board.perform_moves(move) ? @board.perform_moves!(move) : error_prompt("Not valid move")
      rescue StandardError => e
        puts "Please enter valid move."
        retry
      end

      i += 1
      system("clear")
    end
  end

  def won?(color)
    @board.won?(color)
  end

  def error_prompt(message)
    puts message
  end

  def user_prompt(prompt)
    print prompt
    gets.chomp
  end

  def save

  end

end


if $PROGRAM_NAME == __FILE__
  pl1 = Player.new("Marvin", :red)
  pl2 = Player.new("Brian", :black)
  game = Game.new(pl1, pl2)
  game.play
end