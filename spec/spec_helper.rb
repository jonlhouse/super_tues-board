require 'super_tues/game'
require_relative "./helpers/game_steps"

RSpec.configure do |c|
  c.include GameSteps
end