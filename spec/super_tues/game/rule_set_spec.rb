require 'spec_helper'

module SuperTues
  module Game

    describe RuleSet do

      context "when initializing" do
        it "takes a hash" do
          some_rules = {action: { sometime: :else } }
          set = RuleSet.new(some_rules)
          set.rules.should == some_rules
        end
      end
    end

  end
end