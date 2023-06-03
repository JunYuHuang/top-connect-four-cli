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

- `Game` class
  - TODO

- `Player` class
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
