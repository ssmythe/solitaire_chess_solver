require_relative '../../lib/board'

Given(/^a fen of "([^"]*)"$/) do |fen|
  @fen = fen
end

When(/^I setup the board$/) do
  @board = Board.new
  @board.setup(@fen)
end

And(/^I convert the board back to fen$/) do
  @fen = @board.to_fen
end

Then(/^the board should look like$/) do |output|
  @board.to_s.should == output
end

Then(/^the resulting fen should be "([^"]*)"$/) do |output|
  @fen.should == output
end
