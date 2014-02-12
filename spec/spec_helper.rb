require 'super_tues/board'
require 'super_tues/runner'
require_relative "./helpers/game_steps"

RSpec.configure do |c|
  c.include GameSteps
end