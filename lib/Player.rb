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

  def to_s(emoji = nil)
    "#{name} (#{piece.upcase}#{ emoji ? " #{emoji}" : ""})"
  end

  def get_placement
    is_valid_input = true
    last_input = nil
    loop do
      @game.print_turn_screen(is_valid_input, last_input)
      column = gets.chomp
      column_int = column.to_i - 1

      if @game.is_valid_placement?(column_int)
        return column_int
      end

      is_valid_input = false
      last_input = column
    end
  end
end
