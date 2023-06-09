require 'set'

class Game
  attr_accessor(
    :players_count, :rows, :cols, :line_length, :valid_pieces,
    :current_player_piece, :board, :players, :piece_to_string,
    :digit_to_string,
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
    return if @players.size != @players_count

    @current_player_piece = get_random_player.piece

    loop do
      white_player = get_player_by_piece(:white)
      if did_player_win?(white_player)
        print_end_screen(white_player)
        return
      end

      black_player = get_player_by_piece(:black)
      if did_player_win?(black_player)
        print_end_screen(black_player)
        return
      end

      player = get_current_player
      place_piece!(player.piece, player.get_placement)
      switch_players!
    end
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

  def get_player_by_piece(piece)
    return nil if @players.size != @players_count
    res = @players.filter { |p| p.piece == piece }
    res[0]
  end

  def switch_players!
    return if @players.size != @players_count
    return if @current_player_piece.nil?
    @current_player_piece = @current_player_piece == :white ? :black : :white
    nil
  end

  def is_valid_placement?(col)
    return false if col.class != Integer
    return false if col < 0 or col >= @cols

    (0...@rows).reverse_each do |row|
      return true if @board[row][col] == :empty
    end

    false
  end

  def place_piece!(piece, col)
    return if @players.size != @players_count

    (0...@rows).reverse_each do |row|
      if @board[row][col] == :empty
        @board[row][col] = piece
        break
      end
    end
  end

  def did_player_win?(player)
    return false if @players.size != @players_count

    piece = player.piece
    return true if did_win_horizontal?(piece)
    return true if did_win_vertical?(piece)
    return true if did_win_neg_diagonal?(piece)
    return true if did_win_pos_diagonal?(piece)
    false
  end

  def did_win_horizontal?(piece)
    @board.each do |row|
      count = 0
      row.each do |cell|
        count = cell == piece ? count + 1 : 0
        return true if count == @line_length
      end
    end

    false
  end

  def did_win_vertical?(piece)
    (0...@cols).each do |col|
      count = 0
      (0...@rows).reverse_each do |row|
        count = @board[row][col] == piece ? count + 1 : 0
        return true if count == @line_length
      end
    end

    false
  end

  # negative diagonals are lines that go from top left to bottom right
  def did_win_neg_diagonal?(piece)
    # check left / lower half of negative diagonals
    (0..@rows - @line_length).each do |row|
      diag_row = row
      diag_col = 0
      count = 0
      while diag_row < @rows && diag_col < @cols
        count = @board[diag_row][diag_col] == piece ? count + 1 : 0
        return true if count == @line_length
        diag_row += 1
        diag_col += 1
      end
    end

    # check right / upper half of negative diagonals
    (1..@cols - @line_length).each do |col|
      diag_row = 0
      diag_col = col
      count = 0
      while diag_row < @rows && diag_col < @cols
        count = @board[diag_row][diag_col] == piece ? count + 1 : 0
        return true if count == @line_length
        diag_row += 1
        diag_col += 1
      end
    end

    false
  end

  # positive diagonals are lines that go top right to bottom left
  def did_win_pos_diagonal?(piece)
    # check left / upper half of negative diagonals
    (@cols - @line_length..@cols - 2).each do |col|
      diag_row = 0
      diag_col = col
      count = 0
      while diag_row < @rows && diag_col >= 0
        count = @board[diag_row][diag_col] == piece ? count + 1 : 0
        return true if count == @line_length
        diag_row += 1
        diag_col -= 1
      end
    end

    # check right / lower half of negative diagonals
    (0..@rows - @line_length).each do |row|
      diag_row = row
      diag_col = @cols - 1
      count = 0
      while diag_row < @rows && diag_col >= 0
        count = @board[diag_row][diag_col] == piece ? count + 1 : 0
        return true if count == @line_length
        diag_row += 1
        diag_col -= 1
      end
    end

    false
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

  def print_turn_screen(is_valid_input = true, last_input = nil)
    clear_console
    print_board
    print_player_prompt(is_valid_input, last_input)
  end

  def print_end_screen(winner_player)
    clear_console
    print_board
    print_game_end(winner_player)
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

  def clear_console
    is_windows_os = RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
    is_windows_os ? system('cls') : system('clear')
  end

  def print_player_prompt(is_valid_input, last_input)
    return if @current_player_piece.nil? or !get_current_player

    player = get_current_player
    piece = player.piece
    player_string = player.to_s(@@piece_to_string[piece])
    res = [
      "It is #{player_string}'s turn.\n",
      "Empty spots that can have a piece dropped there are indicated by ⭕.\n",
      "Enter a column number from 1 to 7 to drop your piece:\n",
      "#{ is_valid_input ? "" : "❌ '#{last_input}' is an invalid or full column. Try again."}\n",
    ]
    puts(res.join)
  end

  def print_game_end(winner_player)
    winner = winner_player
    piece_emoji = @@piece_to_string[winner_player.piece]
    puts("Game ended: #{winner.to_s(piece_emoji)} won!")
  end
end
