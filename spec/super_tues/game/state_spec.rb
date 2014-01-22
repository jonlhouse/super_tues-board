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
      end

    end

  end
end