require_relative '../../lib/board'

When(/^I move "([^"]*)"$/) do |move|
  @board.move(move)
end
