require 'spec_helper.rb'

module SuperTues
  module Game

    describe Player do     

      describe ".new" do
        subject { Player.new(name: 'player-1', color: :red) }
        it { should be_a Player }
      end

      describe "#name" do
        it "disallows forbidden names" do
          Player.name_allowed?('all').should be_false
          expect { Player.new(name: 'all') }.to raise_error Player::IllegalName
        end
      end

      let(:player) { Player.new(name: 'john', color: :green) }

      describe "#board" do
        let(:board) { Board.new }
        specify { player.board = board ; player.board.should == board }
      end

      let(:board) { Board.new.tap }

      describe "candidate" do
        specify { player.should respond_to :candidate }
      end
    end

  end 
end