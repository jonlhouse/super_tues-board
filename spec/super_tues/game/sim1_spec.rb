require 'spec_helper'

module SuperTues
  module Game

    describe "SuperTues game simulation (1)" do

      let(:player0) { Player.new(name: 'player-0', color: :red) }
      let(:player1) { Player.new(name: 'player-1', color: :blue) }
      let(:player2) { Player.new(name: 'player-2', color: :green) }
      let(:player3) { Player.new(name: 'player-3', color: :yellow) }

      let(:board) { Board.new }

      # adding players to the game
      before(:each) { board.add_players player0, player1, player2, player3 }
      specify { board.players.should == [player0, player1, player2, player3] }

      # seating players
      before(:each) { board.seat_players }
      specify { board.seats.keys.sort.should == (0..3).to_a }

      # dealing candidates
      it "deals candidates to players" do
        board.players.each { |player| expect(player).to receive(:candidates_dealt=) }
        board.deal_candidates
      end

      before(:each) { board.deal_candidates }
    end

  end
end