class Player
  attr_reader :name, :color
  def initialize(name, color)
    @name = name
    @color = color
  end

  def get_input
    ask_from = "#{@name}, choose a piece to move? (ex: 1, 2)"
    ask_to = "To what position? (ex: 2, 3)"
    from = user_prompt(ask_from)
    to = user_prompt(ask_to)

    from_pos = from.split(",").map! { |x| x.to_i }
    to_pos = to.split(",").map! { |x| x.to_i }
    [from_pos, to_pos]
  end

  def user_prompt(prompt)
    print prompt
    gets.chomp
  end
end
