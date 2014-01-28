require 'spec_helper'

module SuperTues
  module Game

    describe Rules do

      describe "default" do
        specify { Rules.default.should be_a RuleSet }
      end     

      describe "rule(str)" do
        let(:rules) { Rules.new }
        # check using default rule: action.radio_spot.picks.max
        specify { expect( rules.rule('action.radio_spot.picks.max') ).to be == 5 }
        

        describe "#[] is alias for rule(str)" do
          specify { expect( rules['action.radio_spot.picks.max'] ).to be == 5 }
        end

      end

      
    end

  end
end
