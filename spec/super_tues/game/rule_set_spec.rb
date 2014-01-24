require 'spec_helper'

module SuperTues
  module Game

    describe RuleSet do

      radio_spot_attrs = { actions: { radio_spot: { max_picks: '3' } } }
      let(:radio_spot) { RuleSet.new(radio_spot_attrs) }
      let(:defaults) { RuleSet.default }

      context "when initializing" do
        specify { radio_spot.rules.should == radio_spot_attrs }

        it "rules are permanent by default" do
          radio_spot.duration.should == RuleSet::PERMANENT
        end
        it "duration is overridable" do
          set = RuleSet.new(radio_spot_attrs, duration: '1')
          set.duration.should == 1
        end
        specify { expect { RuleSet.new({}) }.to raise_error }
      end

      context "default ruleset" do
        specify { defaults.rules.should_not be_empty }
        specify { defaults.duration.should be RuleSet::PERMANENT }
      end

      describe "[] and []=" do
        let(:set) { RuleSet.new({ this: :that }) }
        specify { set[:this].should == :that }
        specify { set[:this] = :other ; set[:this].should == :other }
      end

      describe ".dup" do
        it "clones the underlying hash_set" do
          copy = (original = RuleSet.new(radio_spot_attrs)).dup
          # make sure it's copied
          copy[:actions][:radio_spot][:max_picks].should == original[:actions][:radio_spot][:max_picks]
          # not change it
          copy[:actions][:radio_spot][:max_picks] = 42
          original[:actions][:radio_spot][:max_picks].should_not == 42
        end
      end
    end

  end
end