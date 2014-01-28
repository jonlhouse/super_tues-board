require 'spec_helper'

module SuperTues
  module Game

    describe RuleSet do

      radio_spot_attrs = { action: { radio_spot: { picks: { max: 5 } } } }
      let(:radio_spot) { RuleSet.new(radio_spot_attrs) }
      let(:defaults) { RuleSet.default }

      context "when initializing" do
        specify { radio_spot.rules.should == radio_spot_attrs.deep_stringify_keys }

        describe ":duration option" do
          it "permanent by default" do
            radio_spot.duration.should == :permanent
          end
          it "is overridable" do
            rset = RuleSet.new(radio_spot_attrs, duration: '1')
            rset.duration.should == 1
          end
        end        

        describe ":player option" do
          it "is :any by default" do
            rset = RuleSet.new('some.rule', 42).instance_variable_get(:@affects).should == ['any']
          end
          it "is overridable" do
            rset = RuleSet.new('some.rule', 42, affects: ['player_1']).instance_variable_get(:@affects).should == ['player_1']
          end
        end

        specify { expect { RuleSet.new({}) }.to raise_error }

        describe "can take a single rule string and value" do
          let(:single_rule) { RuleSet.new 'some.made.up.rule', '42' }
          specify { single_rule.rules.should == { 'some' => { 'made' => { 'up' => { 'rule' => 42 } } } } }
        end
      end

      context "default ruleset" do
        specify { defaults.rules.should_not be_empty }
        specify { defaults.duration.should be :permanent }
      end

      describe "#permanent?" do
        specify { RuleSet.new( this: :that).permanent?.should be_true }
        specify { RuleSet.new( { this: :that }, duration: 1).permanent?.should be_false }        
      end

      describe "affects?" do
        let(:select_rule) { RuleSet.new('some.rule', 42, affects: ['player_1', 'player_2']) }
        let(:global_rule) { RuleSet.new('some.rule', 42, affects: :any) }

        specify { select_rule.affects?('player_1').should be }
        specify { select_rule.affects?('player_5').should_not be }

        specify { global_rule.affects?('player_1').should be }
        specify { global_rule.affects?('player_5').should be }
        specify { global_rule.affects?.should be }
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
            legal_not_present_keys = ['other.bad', 'made.up', 'fail']
            legal_not_present_keys.each do |key|
              specify { expect { rset[key, default: 'some_default'].should == 'some_default' }.to_not raise_error }
            end
            it "allows a false default value" do
              rset['made.up.key', default: false].should == false
            end
            it "raises when default is false" do
              expect { rset['made.up.key', default: nil] }.to raise_error
            end
          end
        end        
      end

      describe "has?(key)" do
        let(:rset) { RuleSet.new({ this: :that, other: { foo: :bar } }) }
        let(:has) { ['this', 'other.foo'] }
        let(:has_not) { ['fail', 'foo.fail', 'foo.'] }
        let(:exception) { ['', nil, []] }
        specify { has.each { |key| rset.has?(key).should be_true } }
        specify { has_not.each { |key| rset.has?(key).should be_false } }
        specify { exception.each { |key| expect { rset.has?(key) }.to raise_error } }
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
        end
      end

    end

  end
end