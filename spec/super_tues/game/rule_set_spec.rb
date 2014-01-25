require 'spec_helper'

module SuperTues
  module Game

    describe RuleSet do

      radio_spot_attrs = { actions: { radio_spot: { max_picks: 5 } } }
      let(:radio_spot) { RuleSet.new(radio_spot_attrs) }
      let(:defaults) { RuleSet.default }

      context "when initializing" do
        specify { radio_spot.rules.should == radio_spot_attrs.deep_stringify_keys }

        it "rules are permanent by default" do
          radio_spot.duration.should == RuleSet::PERMANENT
        end
        it "duration is overridable" do
          rset = RuleSet.new(radio_spot_attrs, duration: '1')
          rset.duration.should == 1
        end
        specify { expect { RuleSet.new({}) }.to raise_error }
      end

      context "default ruleset" do
        specify { defaults.rules.should_not be_empty }
        specify { defaults.duration.should be RuleSet::PERMANENT }
      end

      describe "[] and []=" do
        let(:rset) { RuleSet.new({ this: :that, other: { foo: :bar } }) }              
        specify { rset[:this].should == :that }
        specify { rset[:this] = :other ; rset[:this].should == :other }
        specify { expect { rset[] }.to raise_error }

        describe "should raise error when key doesn't exist" do
          specify { expect { rset[nil] }.to raise_error }
          specify { expect { rset[:fail] }.to raise_error }
          specify { expect { rset['other.fail'] }.to raise_error }

          context "unless default is given" do
            specify { expect { rset[:fail, 'works'] }.to_not raise_error }
            specify { (rset[:fail, 'works']).should == 'works' }
          end
        end       

        context "with concattenated keys" do          
          specify { radio_spot['actions.radio_spot.max_picks'].should == 5 }
          specify { radio_spot['actions.radio_spot.made_up_rule', 'default'].should == 'default' }
        end
      end

      describe "numeric values are converted from strings to ints/floats" do
        let(:rset) { RuleSet.new( { integer: '42', float: '42.42', empty: '', nil: nil }) }
        specify { rset[:integer].should == 42 }
        specify { rset[:float].should == 42.42 }
        specify { rset[:empty].should == '' }
        specify { rset[:nil].should == nil }
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