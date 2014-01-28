require 'spec_helper'

module SuperTues
  module Game

    describe Rules do
      let(:board) { double(current_player: 'player-0').as_null_object }
      describe "default" do
        specify { Rules.default.should be_a RuleSet }
      end 

      let(:default) { Rules.new(board) }

      describe "rule(str)" do        
        # check using default rule: action.radio_spot.picks.max
        specify { expect( default.rule('action.radio_spot.picks.max') ).to be == 5 }        

        describe "#[] is alias for rule(str)" do
          specify { expect( default['action.radio_spot.picks.max'] ).to be == 5 }
        end
      end

      describe "#duration" do
        context "when defaults" do
          specify { default.duration('action.radio_spot.picks.max').should == :permanent }
        end
      end

      describe "#ammend" do
        context "with (rule_str, value, duration: dur)" do
          it "should return self" do
            default.ammend('some.new.rule', '42').should == default
          end
          it "should should default to permanent change" do
            default.ammend('some.new.rule', '42')
            default.duration('some.new.rule').should == :permanent
          end
          it "should allow specifying the duration" do
            default.ammend('some.new.rule', '42', duration: 1)
            default.duration('some.new.rule').should == 1
          end
          it "affects :any player by default" do
            default.ammend('some.new.rule', '42')
            default.instance_variable_get(:@rule_heirarchy).first.affects?(:any).should be_true
          end
        end
      end

      describe "current_player rules" do
        context "when no override" do
          specify { default['player.can_play_picks'].should be_true }
        end
        context "when overriden" do
          let(:ammended) { default.ammend('player.can_play_picks', false, affects: :current) }
          specify { ammended['player.can_play_picks', player: board.current_player].should_not be_true }
          specify { ammended['player.can_play_picks', player: 'another-player'].should be_true }
        end
      end

    end

  end
end
