require 'spec_helper'

module SuperTues
  module Game

    describe Rules do
      describe "default" do
        specify { Rules.default.should be_a RuleSet }
      end 

      let(:default) { Rules.new }

      describe "rule(str)" do        
        # check using default rule: action.radio_spot.picks.max
        specify { expect( default.rule('action.radio_spot.picks.max') ).to be == 5 }
        

        describe "#[] is alias for rule(str)" do
          specify { expect( default['action.radio_spot.picks.max'] ).to be == 5 }
        end
      end

      describe "#duration" do
        context "when defaults" do
          specify { default.duration('action.radio_spot.picks.max').should == RuleSet::PERMANENT }
        end
      end

      describe "#ammend" do
        context "with (rule_str, value, duration: dur)" do
          it "should return self" do
            default.ammend('some.new.rule', '42').should == default
          end
          it "should should default to permanent change" do
            default.ammend('some.new.rule', '42')
            default.duration('some.new.rule').should == RuleSet::PERMANENT
          end
          it "should allow specifying the duration" do
            default.ammend('some.new.rule', '42', duration: 1)
            default.duration('some.new.rule').should == 1
          end
        end
      end
    end

  end
end
