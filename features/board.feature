Feature: Solitaire Chess Board

  Amazon listing:

  http://www.amazon.com/Think-Fun-3400-ThinkFun-Solitaire/dp/B0032UKQFO

  A simple way to store board positions for solitaire chess is a partial form of Forsyth-Edwards notation:

  https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation

  The solitaire chess board is composed of 16 squares:

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

  Position:

  4|n|_|_|_|
  3|_|b|_|_|
  2|p|_|_|_|
  1|_|_|_|_|
    a b c d

  ...is represented as: n3/1b2/p3/4

  Scenario: Beginner 1
    Given a fen of "n3/1b2/p3/4"
    When I setup the board
    Then the board should look like
      """
      4|n|_|_|_|
      3|_|b|_|_|
      2|p|_|_|_|
      1|_|_|_|_|
        a b c d
      """

  Scenario: Beginner 2
    Given a fen of "1n2/2b1/r3/4"
    When I setup the board
    Then the board should look like
      """
      4|_|n|_|_|
      3|_|_|b|_|
      2|r|_|_|_|
      1|_|_|_|_|
        a b c d
      """

  Scenario: Beginner 3
    Given a fen of "3r/n1p1/4/n2p"
    When I setup the board
    Then the board should look like
      """
      4|_|_|_|r|
      3|n|_|p|_|
      2|_|_|_|_|
      1|n|_|_|p|
        a b c d
      """

  Scenario: Beginner 4
    Given a fen of "4/1rp1/pr2/4"
    When I setup the board
    Then the board should look like
      """
      4|_|_|_|_|
      3|_|r|p|_|
      2|p|r|_|_|
      1|_|_|_|_|
        a b c d
      """

  Scenario: Beginner 5
    Given a fen of "4/2r1/bq2/1k2"
    When I setup the board
    Then the board should look like
      """
      4|_|_|_|_|
      3|_|_|r|_|
      2|b|q|_|_|
      1|_|k|_|_|
        a b c d
      """

  Scenario Outline: FEN to FEN
    Given a fen of "<fen>"
    When I setup the board
    And I convert the board back to fen
    Then the resulting fen should be "<output>"
    Examples:
      | fen           | output        |
      | n3/1b2/p3/4   | n3/1b2/p3/4   |
      | 1n2/2b1/r3/4  | 1n2/2b1/r3/4  |
      | 3r/n1p1/4/n2p | 3r/n1p1/4/n2p |
      | 4/2r1/bq2/1k2 | 4/2r1/bq2/1k2 |
