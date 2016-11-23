Feature: Solitaire Chess Capture

  In Solitaire Chess, only captures are valid moves

  Given the position:

  4|n|_|_|_|
  3|_|b|_|_|
  2|p|_|_|_|
  1|_|_|_|_|
    a b c d

  There are three initial capture moves available
  a2-b3
  b3-a2
  b3-a4

  Scenario: Beginner 1 - list of a2 captures
    Given a fen of "n3/1b2/p3/4"
    When I setup the board
    And I search for pieces captures for "a2"
    Then the resulting captures should be "a2-b3"

  Scenario: Beginner 1 - list of b3 captures
    Given a fen of "n3/1b2/p3/4"
    When I setup the board
    And I search for pieces captures for "b3"
    Then the resulting captures should be "b3-a2 b3-a4"

  Scenario: Beginner 2 - list of b4 captures
    Given a fen of "1n2/2b1/r3/4"
    When I setup the board
    And I search for pieces captures for "b4"
    Then the resulting captures should be "b4-a2"

  Scenario: Beginner 2 - list of c3 captures
    Given a fen of "1n2/2b1/r3/4"
    When I setup the board
    And I search for pieces captures for "c3"
    Then the resulting captures should be "c3-b4"

  Scenario: Beginner 3 - list of c3 captures
    Given a fen of "3r/n1p1/4/n2p"
    When I setup the board
    And I search for pieces captures for "c3"
    Then the resulting captures should be "c3-d4"

  Scenario: Beginner 3 - list of d4 captures
    Given a fen of "3r/n1p1/4/n2p"
    When I setup the board
    And I search for pieces captures for "d4"
    Then the resulting captures should be "d4-d1"

  Scenario: Beginner 5 - list of d4 captures
    Given a fen of "4/2r1/bq2/1k2"
    When I setup the board
    And I search for pieces captures for "a2"
    Then the resulting captures should be "a2-b1"

  Scenario: Beginner 5 - list of d4 captures
    Given a fen of "4/2r1/bq2/1k2"
    When I setup the board
    And I search for pieces captures for "b2"
    Then the resulting captures should be "b2-a2 b2-b1 b2-c3"

  Scenario: Beginner 5 - list of b1 captures
    Given a fen of "4/2r1/bq2/1k2"
    When I setup the board
    And I search for pieces captures for "b1"
    Then the resulting captures should be "b1-a2 b1-b2"

  Scenario Outline: FEN to Captures
    Given a fen of "<fen>"
    When I setup the board
    And I search for all captures
    Then the resulting captures should be "<captures>"
    Examples:
      | fen           | captures                            |
      | n3/1b2/p3/4   | a2-b3 b3-a2 b3-a4                   |
      | 1n2/2b1/r3/4  | b4-a2 c3-b4                         |
      | 3r/n1p1/4/n2p | c3-d4 d4-d1                         |
      | 4/2r1/bq2/1k2 | a2-b1 b1-a2 b1-b2 b2-a2 b2-b1 b2-c3 |
