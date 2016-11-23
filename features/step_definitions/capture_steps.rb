require_relative '../../lib/board'
require_relative '../../lib/player'

And(/^I search for pieces captures for "([^"]*)"$/) do |algebraic|
  log = Logger.new($stderr)
  log.level = Logger::DEBUG

  player = Player.new
  @captures = player.find_captures_for_piece(@board, algebraic, @board.square_algebraic(algebraic)).join(' ')
end

And(/^I search for all captures$/) do
  player = Player.new
  @captures = player.find_captures(@board).join(' ')
end

Then(/^the resulting captures should be "([^"]*)"$/) do |output|
  @captures.should == output
end
