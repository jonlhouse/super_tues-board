require 'spec_helper.rb'

module SuperTues
  module Board

    describe Player do     

      describe ".new" do
        subject { Player.new(name: 'player-1') }
        it { should be_a Player }
      end

      describe "#name" do
        it "disallows forbidden names" do
          Player.name_allowed?('all').should be_false
          expect { Player.new(name: 'all') }.to raise_error Player::IllegalName
        end
      end

      let(:game) { Game.new }
      let(:player) { Player.new(name: 'john') }

      describe "#game" do
        let(:game) { Game.new }
        specify { player.game = game ; player.game.should == game }
      end    

      describe "#candidate" do
        specify { player.should respond_to :candidate }
      end

      describe "#pick_candidate" do        
        [:a, :b, :c, :d].each { |sym| let(sym) { double } }
        before(:each) do
          player.candidates_dealt = [a, b, c]
          player.stub(:game) { double(candidate_available?: true) }
        end
        specify { player.candidate = a ; player.candidate.should == a }
        it "raises IllegalCandidate when not in list dealt" do
          expect { player.candidate = d }.to raise_error Player::IllegalCandidate
        end
        it "raises IllegalCandidate if it is taken" do
          player.stub(:game) { double(candidate_available?: false) }
          expect { player.candidate = :a }.to raise_error Player::IllegalCandidate
        end
      end

      let(:player) { Player.new(name: 'john').tap { |p| p.game = game } }

      describe "#seat" do
        before(:each) { player.game.stub(:players) { %w(0 1 2 3) } }
        it "raises error unless game set" do
          player.game = nil
          expect { player.seat = 0 }.to raise_error(Player::NotAtGame)
        end
        it "raises error when seated out of range" do
          expect { player.seat = 5 }.to raise_error(Player::IllegalSeat)
        end
        it "raises when another player is in that seat" do
          game.stub(:seat_taken?) { true }
          expect { player.seat = 0 }.to raise_error(Player::IllegalSeat)
        end
        it "correctly assigned" do
          game.stub(:seat_taken?) { false }
          player.seat = 0
          player.seat.should == 0
        end
      end

      describe "cash, clout, card accessors" do
        specify { player.cash = Cash.new(5) ; player.cash.should == 5 }
        specify { player.clout = Clout.new(5) ; player.clout.should == 5 }
        specify { player.cards = [c = double] ; player.cards.should == [c] }
      end

      describe "#seed_funds" do
        it "raises error unless candidate is picked" do
          expect { player.candidate = nil ; player.seed_funds }.to raise_error
        end
        describe "adds cash, clout and cards to player's funds" do
          specify { expect { player.seed_funds }.to change {player.cash} }
          specify { expect { player.seed_funds }.to change {player.clout} }
          specify { expect { player.seed_funds }.to change {player.cards} }
        end
      end

      describe "#color" do
        specify { expect { player.color = :red }.to change { player.color }.from(nil).to(:red) }
      end

    end
  end 
end