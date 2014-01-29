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

      let(:board) { Board.new }
      let(:player) { Player.new(name: 'john', color: :green) }

      describe "#board" do
        let(:board) { Board.new }
        specify { player.board = board ; player.board.should == board }
      end    

      describe "#candidate" do
        specify { player.should respond_to :candidate }
      end

      describe "#pick_candidate" do        
        [:a, :b, :c, :d].each { |sym| let(sym) { double } }
        before(:each) do
          player.candidates_dealt = [a, b, c]
          player.stub(:board) { double(candidate_available?: true) }
        end
        specify { player.candidate = a ; player.candidate.should == a }
        it "raises IllegalCandidate when not in list dealt" do
          expect { player.candidate = d }.to raise_error Player::IllegalCandidate
        end
        it "raises IllegalCandidate if it is taken" do
          player.stub(:board) { double(candidate_available?: false) }
          expect { player.candidate = :a }.to raise_error Player::IllegalCandidate
        end
      end

      let(:player) { Player.new(name: 'john', color: :green).tap { |p| p.board = board } }

      describe "#seat" do
        before(:each) { player.board.stub(:players) { %w(0 1 2 3) } }
        it "raises error unless board set" do
          player.board = nil
          expect { player.seat = 0 }.to raise_error(Player::NotAtGame)
        end
        it "raises error when seated out of range" do
          expect { player.seat = 5 }.to raise_error(Player::IllegalSeat)
        end
        it "raises when another player is in that seat" do
          board.stub(:seat_taken?) { true }
          expect { player.seat = 0 }.to raise_error(Player::IllegalSeat)
        end
        it "correctly assigned" do
          board.stub(:seat_taken?) { false }
          player.seat = 0
          player.seat.should == 0
        end
      end
    end

  end 
end