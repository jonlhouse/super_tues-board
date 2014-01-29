require 'spec_helper'

module SuperTues
  module Game

    describe "SuperTues game simulation (1)" do

      let(:player0) { Player.new(name: 'player-0', color: :red) }
      let(:player1) { Player.new(name: 'player-1', color: :blue) }
      let(:player2) { Player.new(name: 'player-2', color: :green) }
      let(:player3) { Player.new(name: 'player-3', color: :yellow) }

      let(:board) { Board.new }

      describe "during game setup" do
        describe "assigns players to the board" do
          it "seats players" do
            board.seat player0
            board.seat player1
            board.seat player2
            board.seat player3
            board.seats.should == [player0, player1, player2, player3]
          end
          
        end
      end
    end

  end
end