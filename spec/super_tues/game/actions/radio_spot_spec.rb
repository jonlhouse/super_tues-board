require 'spec_helper'

module SuperTues
  module Game
    module Actions
      describe RadioSpot do
        specify { RadioSpot.should < PlayPicks }

        describe "#initialize(params)" do
          attrs = { 'Indiana' => 1, 'Florida' => 3, 'South Dakoda' => 1 }
          radio_spot = RadioSpot.new attrs
          radio_spot.instance_variable_get(:@state_picks).should == attrs
        end

        describe "#allowed?(rules)" do
          let(:rules) { Board.new.rules }
          context "true when" do
            it "<= max picks" do
              RadioSpot.new('Florida' => 5).allowed?(rules).should be_true
            end
            it "spead state by default" do
              RadioSpot.new('Florida' => 1, 'Indiana' => 1).allowed?(rules).should be_true
            end
            it "someone else can't play picks" do
              new_rules = rules.ammend 'player.can_play_picks', false, player: 'player-abc'
              RadioSpot.new('Florida' => 1).allowed?(new_rules).should be_true
            end
          end
          context "false when" do
            it "> max picks" do
              RadioSpot.new('Florida' => 6).allowed?(rules).should be_false
            end
            it "spread states when rules forbid" do
              new_rules = rules.ammend 'action.radio_spot.picks.spread', false
              RadioSpot.new('Florida' => 1, 'Indiana' => 1).allowed?(new_rules).should be_false
            end
            it "forbidden from playing picks" do
              new_rules = rules.ammend 'player.can_play_picks', false, player: :current
              RadioSpot.new('Florida' => 1).allowed?(new_rules).should be_false
            end
          end          
        end
      end
    end
  end
end
