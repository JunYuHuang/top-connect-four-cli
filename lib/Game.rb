require 'set'

class Game
  attr_accessor(
    :rows, :cols, :line_length, :valid_pieces, :current_player_piece,
    :board, :players, :piece_to_string, :digit_to_string
  )

  @@valid_pieces = Set.new([:black, :white, :empty])

  @@piece_to_string = {
    black: "⚫",
    white: "⚪",
    empty: "⭕"
  }

  @@digit_to_string = {
    1 => "1️⃣", 2 => "2️⃣", 3 => "3️⃣", 4 => "4️⃣",
    5 => "5️⃣", 6 => "6️⃣", 7 => "7️⃣"
  }

  def initialize(board = nil, player_class = nil)
    @rows = 6
    @cols = 7
    @line_length = 4
    @current_player_piece = nil
    @board = self.class.is_valid_board?(board) ? board : self.class.get_empty_board
    @players = []

    return unless player_class

    2.times do |i|
      @players.push(
        player_class.new(
          self,
          "Player #{@players.size + 1}",
          @players.empty? ? :black : :white
        )
      )
    end
  end

  def add_player(player_class)
    # TODO
  end

  private

  def self.is_valid_board?(board, rows = 6, cols = 7)
    return false if board.class != Array
    return false if board.size != rows
    return false if board.any? { |el| el.class != Array }
    return false if board.any? { |el| el.size != cols }

    board.each do |col|
      return false if col.any? { |cell| !@@valid_pieces.include?(cell) }
    end

    last_col = cols - 1
    last_row = rows - 1
    second_last_row = rows - 2
    # returns false if there is a non-empty piece (e.g. black or white)
    # on "top" of an empty spot in any column because cannot have game
    # pieces floating on top of air
    (0..last_col).each do |col|
      prev = board[last_row][col]
      (0..second_last_row).reverse_each do |row|
        return false if prev == :empty && board[row][col] != :empty
      end
    end

    true
  end

  def self.get_empty_board(rows = 6, cols = 7)
    Array.new(rows) { Array.new(cols, :empty) }
  end
end
