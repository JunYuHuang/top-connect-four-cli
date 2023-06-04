class PlayerMock
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
end
