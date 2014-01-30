require 'spec_helper.rb'

module SuperTues
  module Game

    describe State do

      let(:state) { State.new(name: 'California', abbr: 'CA', electoral_votes: 55, sway: -1) }

      describe "initial state" do
        specify { state.name.should == 'California' }
        specify { state.abbr.should == 'CA' }
        specify { state.electoral_votes.should == 55 }
        specify { state.sway.should == -1 }
        specify { state.picks.should == {} }
      end

      describe "defaults to zero picks per player" do
        specify { state.picks[:red].should == 0 }
        it "also works for players" do
          state.picks[double('player', to_sym: :blue)].should == 0
        end
      end

      describe "#add" do
        it "picks are added by color" do
          state.picks.add :red, 10
          state.picks[:red].should == 10
        end
      end

      describe "total picks" do
        before(:each) { state.picks.add(:red, 2) ; state.picks.add(:blue, 8) }
        specify { state.picks.total.should == 10 }
      end

    end

  end
end