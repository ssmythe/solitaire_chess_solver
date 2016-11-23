require_relative '../../lib/board'
require_relative '../../lib/player'
require_relative '../../lib/solver'

And(/^I search for the solution$/) do
  solver = Solver.new
  @solution = solver.find_solution(@board)
end

Then(/^the resulting solution should be "([^"]*)"$/) do |output|
  @solution.should == output
end
