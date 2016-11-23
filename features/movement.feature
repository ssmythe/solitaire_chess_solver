Feature: Solitaire Chess Movement

  A simple way to represent piece movement is coordinate notation:

  https://en.wikipedia.org/wiki/Chess_notation

  e chess board is composed of 16 squares:

  4|_|_|_|_|
  3|_|_|_|_|
  2|_|_|_|_|
  1|_|_|_|_|
    a b c d

  Board coordinates are in coordinate notation: a1 (lower left), d4 (upper right)

  https://en.wikipedia.org/wiki/Chess_notation

  Pieces:

  p = pawn
  b = bishop
  n = knight
  r = rook
  q = queen
  k = king

  Given the position:

  4|n|_|_|_|
  3|_|b|_|_|
  2|p|_|_|_|
  1|_|_|_|_|
    a b c d

  After the move "a2-b3", the board would look like:

  4|n|_|_|_|
  3|_|p|_|_|
  2|_|_|_|_|
  1|_|_|_|_|
    a b c d

  Scenario: Beginner 1 Move 1
    Given a fen of "n3/1b2/p3/4"
    When I setup the board
    And I move "a2-b3"
    Then the board should look like
      """
      4|n|_|_|_|
      3|_|p|_|_|
      2|_|_|_|_|
      1|_|_|_|_|
        a b c d
      """

  Scenario: Beginner 1 Move 2
    Given a fen of "n3/1p2/4/4"
    When I setup the board
    And I move "b3-a4"
    Then the board should look like
      """
      4|p|_|_|_|
      3|_|_|_|_|
      2|_|_|_|_|
      1|_|_|_|_|
        a b c d
      """
