require 'spec_helper'

module SuperTues
  module Runner

    describe GameRunner do
      let(:game) { Board::Game.new }
      let(:runner) { GameRunner.new(game) }

      specify { expect(runner).to be_a GameRunner }
    end

  end
end