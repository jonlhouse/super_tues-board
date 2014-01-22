require 'spec_helper.rb'

module SuperTues
  module Game

    describe Player do
      let(:board) { Board.new }
      let(:player) { Player.new('john', board) }

      specify { player.should be_a Player }

      describe "board" do
        # all players belong to a board
        specify { player.board.should == board }
        # not 'setable'
        specify { expect { player.board = Board.new }.to raise_error }
      end

      describe "name" do
        specify { player.name.should == 'john' }
        
        let(:rename) { player.tap { |p| p.name = 'jimmy' } }
        specify { rename.name.should == 'jimmy' }
      end

      describe "candidate" do
        specify { player.should respond_to :candidate }
      end
    end

  end 
end