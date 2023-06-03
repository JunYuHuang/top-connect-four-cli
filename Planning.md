# Planning Notes

## Basic Game Rules and Mechanics

- 2 player PVP game where each player has their own one-coloured piece set
  - usually 1 player has red pieces while the other has yellow pieces
- up to players to decide who goes first
- first player to make form an unbroken, consecutive line of size 4 consisting of their coloured pieces wins; other player loses
  - line can be:
    - horizontal OR
    - vertical OR
    - diagonal (negative or positive diagonal)
- played on a 7 x 6 (width x height) game board
- coloured pieces from either player
  - cannot be removed once placed
  - can block "lines" formed by pieces from the opposing players
  - can only be "placed" or dropped in 1 of 7 columns
  - will always be placed in the bottom-most row of any column selected for a player's turn move
  - cannot be placed in "full" columns i.e. columns that already have 6-stacked coloured pieces
  - can only be placed in non-full or empty columns
- players can
  - only select a valid game board column to place their piece
  - NOT directly choose a row that is not the bottom-most row in a column to place their piece at (e.g. place a piece in the top-most row of a column when that column is empty of any pieces)
  - only place 1 of their piece during their turn
- game turn alternates between both player after each turn
- zero sum game
  - only one player can win; other player auto-loses
  - no tie is possible

## MVP Requirements

- 2 human players only; no computer bot player / algorithm
- use black ⚫ and white ⚪ pieces to represent the player's piece
- game randomly selects a player to go first
- console UI 'screens'
  - in-progress game turn screen
    - display game board
    - display which player's turn it is
    - prompt player for input
      - input is a integer value in the range \[1, 7] that represents a column on the game board they can place their piece in
  - game end result screen
    - display game board
    - display who won the game and lost

## Game Logic and Basic Pseudocode

- initialise game
  - set player 1 to use black pieces
  - set player 2 to use white pieces
- while game is not over
  - if turn has not been set
    - randomly select a player and set the current turn to be theirs
  - get column input from current turn's player
    - while the input is invalid (not a valid column or the selected column is full)
      - prompt again for a valid input
    - update the game state
  - if the current player won
    - display the game end summary screen
    - return and exit the game

## Expanded Pseudocode / Partial Code

- `Player` class
  - constructor(game, name, piece)
    - @`game`: `Game` object / instance
    - @`name`: string for player e.g. `Player 1`
    - @`piece`: symbol that represents player's coloured game piece e.g. `:black`
  - piece()
    - returns @`piece`
  - name()
    - returns @`name`
  - get_placement()
    - gets human player's column input

- `Game` class
  - @@`piece_to_string`: hashmap that maps each piece symbol to a string to display or print in the console output
    - { black: ⚫, white: ⚪, empty: ⭕ }
  - constructor(player_1_class, player_2_class)
    - instantiates and assigns player_1_class the following:
      - `name` = "Player 1"
      - `piece` = :black
    - instantiates and assigns player_2_class the following:
      - `name` = "Player 2"
      - `piece` = :white
    - @`players`: array of player class instances
    - @`current_player_piece`: set initially to null
      - stores the symbol that represents the piece of the player whose turn it currently is
    - @`rows`: integer set to 6 representing the height of the game board
    - @`cols`: integer set to 7 representing the width of the game board
    - @`line_length`: integer set to 4 representing the (min?) size of consecutive same pieces in a line a player needs to win the game
    - @`board`: 2D array / matrix of symbols that represents the game board
      - `board.size` = @`rows`
      - `board[row].size` = @`cols`
      - `board[row][col]` = a symbol from the set { :black, :white: :empty }
  - play
    - while true
      - if there is no current player set
        - @`current_player_piece` = get_random_player().piece()
      - current_player = get_current_player()
      - place_piece!(current_player)
      - if did_player_win?(current_player)
        - clear_console()
        - print_board()
        - print_game_end()
        - return
      - switch_player_turn!()
  - add_player(player_class)
    - returns if there are already 2 players in the game
    - adds up to 2 players to the @`players` array
  - is_current_player_set?
    - returns true if @`current_player_piece` is `:black` or `:white` else false
  - is_valid_placement?(column)
    - returns false if column is not an integer
    - returns false if column is out-of-bounds
    - returns true if column is not full
  - place_piece!(player_obj)
    - col = player_obj.get_col()
    - loop thru row `r` from @`rows` - 1 to 0 in @`board[r][col]`
      - if @`board[r][c]` is not `:empty`, continue
      - @`board[r][c]` = player_obj.piece
      - break
  - get_random_player
    - randomly selects a player object from @`players` and returns it
  - get_current_player
    - TODO
  - did_player_win_horizontal?(player)
    - TODO
  - did_player_win_vertical?(player)
    - TODO
  - did_player_win_neg_diagonal?(player)
    - TODO
  - did_player_win_pos_diagonal?(player)
    - TODO
  - did_player_win?(player)
    - returns true if any of the 4 specialized `did_player_win_`-prefixed  methods return true
  - switch_player_turn!
    - TODO
  - clear_console()
    - TODO
  - print_board()
    - TODO
  - print_player_prompt(is_valid_input, last_input)
    - TODO
  - print_game_end()
    - TODO

## UI Design

### Turn Screen

```
⭕⭕⭕⭕⭕⭕⭕
⭕⭕⭕⭕⭕⭕⭕
⭕⭕⭕⭕⭕⭕⭕
⭕⭕⭕⭕⭕⭕⭕
⭕⭕⚫⭕⭕⭕⭕
⭕⭕⚪⚫⚪⭕⭕
1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣

It is Player 1 (BLACK ⚫)'s turn.
⭕ indicates an empty spot that can have a piece dropped there.
'x' is an invalid or full column. Try again.
Enter a column (in the range [1,7]) to drop your piece:
x
```

### End Screen

```
⭕⭕⭕⭕⭕⭕⭕
⭕⭕⭕⭕⭕⭕⭕
⚫⭕⭕⭕⭕⭕⭕
⚪⚫⭕⭕⭕⭕⭕
⚪⚪⚫⭕⭕⭕⭕
⚫⚪⚪⚫⚪⭕⭕
1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣

Game ended: Player 1 (BLACK ⚫) won the game!
```
