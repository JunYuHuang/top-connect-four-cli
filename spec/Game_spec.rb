require './lib/Game'
require './spec/PlayerMock'

describe Game do
  describe ".is_valid_board?" do
    it "returns false if called with a non-array object or value" do
      expect(Game.is_valid_board?(nil)).to eql(false)
    end

    it "returns false if called with an array whose size (rows) is not its default value of 6" do
      expect(Game.is_valid_board?([])).to eql(false)
    end

    it "returns false if called with an array whose elements are not subarrays" do
      expect(Game.is_valid_board?(["a","a","a","a","a","a"])).to eql(false)
    end

    it "returns false if called with an array whose elements are subarrays not of the default column length of 7" do
      board = [
        ["a","a","a","a","a","a"],
        ["a","a","a","a","a","a"],
        ["a","a","a","a","a","a"],
        ["a","a","a","a","a","a"],
        ["a","a","a","a","a","a"],
        ["a","a","a","a","a","a"],
      ]
      expect(Game.is_valid_board?(board)).to eql(false)
    end

    it "returns false if called with an array whose elements are subarrays of the right size but don't contain valid game pieces" do
      board = [
        [nil, nil, nil, nil, nil, nil, :nil],
        [nil, nil, nil, nil, nil, nil, :nil],
        [nil, nil, nil, nil, nil, nil, :nil],
        [nil, nil, nil, nil, nil, nil, :nil],
        [nil, nil, nil, nil, nil, nil, :nil],
        [nil, nil, nil, nil, nil, nil, :nil],
      ]
      expect(Game.is_valid_board?(board)).to eql(false)
    end

    it "returns false if called with a 2D array of the right dimensions where there is a non-empty piece symbol not in the bottom-most row of its cell" do
      board = [
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :white, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :black, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
      ]
      expect(Game.is_valid_board?(board)).to eql(false)
    end

    it "returns true if called with a 2D array of the right dimensions where every value of its subarray is an :empty piece symbol" do
      board = [
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
      ]
      expect(Game.is_valid_board?(board)).to eql(true)
    end

    it "returns true if called with a 2D array of the right dimensions where there are some valid game pieces in the bottom-most row" do
      board = [
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :black, :white, :white, :empty, :empty, :empty],
      ]
      expect(Game.is_valid_board?(board)).to eql(true)
    end

    it "returns true if called with a 2D array of the right dimensions where there are some valid non-empty game pieces stacked on top of each other" do
      board = [
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :black, :empty, :empty, :empty, :empty, :empty],
        [:empty, :white, :white, :empty, :empty, :empty, :empty],
        [:empty, :black, :black, :white, :empty, :empty, :empty],
      ]
      expect(Game.is_valid_board?(board)).to eql(true)
    end
  end

  describe ".get_empty_board" do
    it "returns an empty game board if called" do
      board = [
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
      ]
      expect(Game.get_empty_board).to eql(board)
    end
  end

  describe "#initialize" do
    it "returns a non-null instance if called with no parameters" do
      expect(Game.new).to_not eql(nil)
    end

    it "returns a non-null instance if called with a valid board argument" do
      board = [
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
      ]
      expect(Game.new(board)).to_not eql(nil)
    end

    it "returns a non-null instance if called with a valid board argument" do
      game = Game.new(nil, PlayerMock)
      expect(game).to_not eql(nil)
      expect(game.players[0].name).to eql("Player 1")
      expect(game.players[0].piece).to eql(:black)
    end
  end

  describe "#add_player" do
    it "adds a new player with name 'Player 1' and with the black piece to the game if called with a Player class on a game with no players" do
      game = Game.new
      game.add_player(PlayerMock)
      res = [game.players[0].name, game.players[0].piece]
      expected = ["Player 1", :black]
      expect(res).to eql(expected)
    end

    it "adds a new player with name 'Player 2' and with the white piece to the game if called with a Player class on a game with 1 player" do
      game = Game.new
      game.add_player(PlayerMock)
      game.add_player(PlayerMock)
      res = [game.players[1].name, game.players[1].piece]
      expected = ["Player 2", :white]
      expect(res).to eql(expected)
    end

    it "does nothing if called with a Player class on a game with 2 players" do
      game = Game.new
      game.add_player(PlayerMock)
      game.add_player(PlayerMock)
      game.add_player(PlayerMock)
      expect(game.players.size).to eql(2)
    end
  end

  describe "#is_current_player_set?" do
    it "returns false if called and the game's current player piece has not been set" do
      game = Game.new
      expect(game.is_current_player_set?).to eql(false)
    end

    it "returns false if called and the game's current player piece has been set to the :empty symbol" do
      game = Game.new
      game.current_player_piece = :empty
      expect(game.is_current_player_set?).to eql(false)
    end

    it "returns false if called and the game's current player piece has been set to '1'" do
      game = Game.new
      game.current_player_piece = 1
      expect(game.is_current_player_set?).to eql(false)
    end

    it "returns true if called and the game's current player piece has been set to the :white symbol" do
      game = Game.new
      game.current_player_piece = :white
      expect(game.is_current_player_set?).to eql(true)
    end
  end

  describe "#get_random_player" do
    it "returns nil if called on a game with 0 players" do
      game = Game.new
      expect(game.get_random_player).to eql(nil)
    end

    it "returns a random player object if called on a game with 2 players" do
      game = Game.new(nil, PlayerMock)
      expect(game.get_random_player).to_not eql(nil)
    end
  end

  describe "#get_current_player" do
    it "returns nil if called on a game with 0 players" do
      game = Game.new
      expect(game.get_current_player).to eql(nil)
    end

    it "returns nil if called on a game with 2 players but there is no current player piece set" do
      game = Game.new(nil, PlayerMock)
      expect(game.get_current_player).to eql(nil)
    end

    it "returns the player object if called on a game with 2 players with a current player piece set" do
      game = Game.new(nil, PlayerMock)
      game.current_player_piece = :white
      expect(game.get_current_player).to_not eql(nil)
    end
  end
end
