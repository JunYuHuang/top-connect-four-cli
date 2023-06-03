class Player
  attr_accessor(:game, :name, :piece)

  def initialize(game, name, piece)
    @game = game
    @name = name
    @piece = piece
  end

  def piece
    @piece
  end

  def name
    @name
  end

  def get_placement
    is_valid_input = true
    last_input = nil
    loop do
      @game.print_board
      @game.print_player_prompt(is_valid_input, last_input)
      column = gets.chomp.downcase

      if @game.is_valid_placement?(column)
        return column
      end

      is_valid_input = false
      last_input = column
    end
  end
end
