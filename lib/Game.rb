require 'set'

class Game
  attr_accessor(
    :players_count, :rows, :cols, :line_length, :valid_pieces,
    :current_player_piece, :board, :players, :piece_to_string, :digit_to_string
  )

  @@valid_pieces = Set.new([:black, :white, :empty])

  @@piece_to_string = {
    black: "⚫",
    white: "⚪",
    empty: "⭕"
  }

  @@digit_to_string = {
    1 => "1️⃣ ", 2 => "2️⃣ ", 3 => "3️⃣ ", 4 => "4️⃣ ",
    5 => "5️⃣ ", 6 => "6️⃣ ", 7 => "7️⃣ "
  }

  def initialize(board = nil, player_class = nil)
    @players_count = 2
    @rows = 6
    @cols = 7
    @line_length = 4
    @current_player_piece = nil
    @board = self.class.is_valid_board?(board) ? board : self.class.get_empty_board
    @players = []

    return unless player_class

    @players_count.times do |i|
      @players.push(player_class.new(
        self,
        "Player #{@players.size + 1}",
        @players.empty? ? :black : :white
      ))
    end
  end

  def add_player(player_class)
    return if @players.size >= @players_count
    @players.push(player_class.new(
      self,
      "Player #{@players.size + 1}",
      @players.empty? ? :black : :white
    ))
  end

  def play
    # TODO
  end

  def is_current_player_set?
    return false if @current_player_piece.nil?
    return false if @current_player_piece == :empty
    @@valid_pieces.include?(@current_player_piece)
  end

  def get_random_player
    return nil if @players.size != @players_count
    @players[rand(0...@players_count)]
  end

  def get_current_player
    return nil if @players.size != @players_count
    res = @players.filter { |p| p.piece == @current_player_piece }
    res[0]
  end

  def switch_players!
    return if @players.size != @players_count
    @current_player_piece == :white ? :black : :white
  end

  def is_valid_placement?(column)
    # TODO
  end

  def place_piece!(player)
    # TODO
  end

  def did_player_win?(player)
    # TODO
  end

  def print_turn_screen(is_valid_input, last_input)
    # TODO
  end

  def print_end_screen
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
        prev = board[row][col]
      end
    end

    true
  end

  def self.get_empty_board(rows = 6, cols = 7)
    Array.new(rows) { Array.new(cols, :empty) }
  end

  def did_player_win_horizontal?(player)
    # TODO
  end

  def did_player_win_vertical?(player)
    # TODO
  end

  def did_player_win_neg_diagonal?(player)
    # TODO
  end

  def did_player_win_pos_diagonal?(player)
    # TODO
  end

  def clear_console
    is_windows_os = RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
    is_windows_os ? system('cls') : system('clear')
  end

  def print_board
    wall = "|"
    res = []

    @board.each do |row|
      row_display = [wall]
      row.each do |cell|
        row_display.push(@@piece_to_string[cell])
      end
      row_display.push(wall, "\n")
      res.push(row_display.join)
    end

    col_labels = (1..@cols).to_a.map { |i| @@digit_to_string[i] }
    col_row = [wall, col_labels.join, wall, "\n"]
    res.push(col_row.join, "\n")

    puts(res.join)
  end

  def print_player_prompt(is_valid_input, last_input)
    # TODO
  end

  def print_game_end
    # TODO
  end
end
