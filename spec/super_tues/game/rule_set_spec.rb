require 'spec_helper'

module SuperTues
  module Game

    describe RuleSet do

      radio_spot_attrs = { action: { radio_spot: { picks: { max: 5 } } } }
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

      describe "[]" do
        let(:rset) { RuleSet.new({ this: :that, other: { foo: :bar } }) }
        describe "single keys can be accessed with a symbol" do
          specify { rset[:this].should == :that }
        end
        describe "takes only a dot.seperated.string" do
          specify { rset['this'].should == :that }
          specify { rset['other.foo'].should == :bar }
        end
        describe "can only access end-point rules" do
          specify { expect { rset['other'] }.to raise_error }
        end
        describe "raises error when key not found" do
          fail_keys = ['other.fail', '', nil, 'fail']
          fail_keys.each do |key|
            specify { expect { rset[key] }.to raise_error }
          end

          describe "exception not thrown if default given" do
            fail_keys.each do |key|
              specify { expect { rset[key, 'some_default'].should == 'some_default' } }
            end
          end
        end        
      end

      describe "[]=" do
        let(:rset) { RuleSet.new({ this: :that, other: { foo: :bar } }) }
        it "can change existing values" do
          ['this', 'other.foo'].each do |key|
            rset[key] = 'new_value'
            rset[key].should == 'new_value'
          end
        end
        it "can 'build' it's way out creating new hashes as needed" do
          rset['a.b.c.d'] = 'new_value'          
          rset['a.b.c.d'].should == 'new_value'
        end
        it "can set a hash as a value" do
          rset['a.b.c.d'] = { e: { f: :g, h: { i: 42 } } }
          rset['a.b.c.d.e.h.i'].should == 42
        end
        it "converts int/float/bools" do
          { '42' => 42, '12.12' => 12.12, 'true' => true }.each do |expected, actual|
            rset['test'] = expected
            rset['test'].should == actual
          end
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
          copy['action.radio_spot.picks.max'].should == original['action.radio_spot.picks.max']
          copy['action.radio_spot.picks.max'] = 42
          original['action.radio_spot.picks.max'].should_not == 42
          # make sure it's copied
          # copy[:action][:radio_spot][:picks][:max].should == original[:action][:radio_spot][:picks][:max]
          # # not change it
          # copy[:action][:radio_spot][:picks][:max] = 42
          # original[:actions][:radio_spot][:max_picks].should_not == 42
        end
      end

    end

  end
end