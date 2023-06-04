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
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :white, :empty, :empty, :empty, :empty, :empty],[:empty, :empty, :empty, :black, :empty, :empty, :empty],[:empty, :empty, :empty, :empty, :empty, :empty, :empty],
      ]
      expect(Game.is_valid_board?(board)).to eql(false)
    end

    it "returns true if called with a 2D array of the right dimensions where every value of its subarray is an :empty piece symbol" do
      board = [
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :empty, :empty, :empty, :empty, :empty, :empty],
      ]
      expect(Game.is_valid_board?(board)).to eql(true)
    end

    it "returns true if called with a 2D array of the right dimensions where there are some valid game pieces in the bottom-most row" do
      board = [
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :black, :white, :white, :empty, :empty, :empty],
      ]
      expect(Game.is_valid_board?(board)).to eql(true)
    end

    it "returns true if called with a 2D array of the right dimensions where there are some valid non-empty game pieces stacked on top of each other" do
      board = [
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :black, :empty, :empty, :empty, :empty, :empty],[:empty, :white, :white, :empty, :empty, :empty, :empty],[:empty, :black, :black, :white, :empty, :empty, :empty],
      ]
      expect(Game.is_valid_board?(board)).to eql(true)
    end
  end

  describe ".get_empty_board" do
    it "returns an empty game board if called" do
      board = [
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :empty, :empty, :empty, :empty, :empty, :empty],
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
        [:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :empty, :empty, :empty, :empty, :empty, :empty],[:empty, :empty, :empty, :empty, :empty, :empty, :empty],
      ]
      expect(Game.new(board)).to_not eql(nil)
    end
  end
end
