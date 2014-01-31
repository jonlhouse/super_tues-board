require 'spec_helper'

module SuperTues
  module Game
    describe FrontRunner do

      let(:p1) { double('p1', score: 10) }
      let(:p2) { double('p2', score: 20) }
      let(:p3) { double('p3', score: 40) }
      let(:board) { double 'board', players: [p1, p2, p3] }

      describe "#random" do
        specify { expect(FrontRunner.new(board, nil).random).to be_in [p1, p2, p3] }
      end

      describe "#is" do
        specify { FrontRunner.new(board, nil).is.should be_nil }
        specify { FrontRunner.new(board, p1).is.should be == p1 }
      end

      describe "#select" do       
        
        it "#select returns the top score player" do
          expect(FrontRunner.new(board).select).to be == p3
        end

        it "when two players have the same score it goes to the previous frontrunner" do
          p4 = double 'p4', score: 40
          board = double players: [p1, p2, p3, p4]
          expect(FrontRunner.new(board, p4).select).to be == p4
        end
      end

    end
  end
end