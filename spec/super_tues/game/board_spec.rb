require 'spec_helper.rb'

module SuperTues
  module Game

    describe Board do
      let(:board) { Board.new }

      context "new game" do
        specify { board.should be_a Board }
      end

      describe "players" do
        
        it "add players and updates player's board" do
          board.add_players('bob', 'tom')
          board.players.count.should == 2 
          board.players.each { |player| player.board.should == board }          
        end

      end
      
    end

  end
end