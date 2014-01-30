require 'spec_helper'

module SuperTues
  module Game
    describe FrontRunner do

      describe "is" do
        let(:p1) { double(score: 10) }
        let(:p2) { double(score: 20) }
        let(:p3) { double(score: 40) }
        let(:board) { double 'board', players: [p1, p2, p3] }
        it "#is returns the top score player" do
          expect(FrontRunner.new(board).is).to be == p3
        end
      end

    end
  end
end