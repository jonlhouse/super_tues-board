require 'spec_helper'

module SuperTues
  module Game
    module Actions
      describe RadioSpot do
        specify { RadioSpot.should < Action }

        describe "#initialize(params)" do
          attrs = { 'Indiana' => 1, 'Florida' => 3, 'South Dakoda' => 1 }
          radio_spot = RadioSpot.new attrs
          radio_spot.instance_variable_get(:@picks).should == attrs
        end

        describe "#allow?(rules)" do
          let(:rules) { Board.new.rules }
          context "false when" do
            it "> max picks" do
              RadioSpot.new(picks: { 'Florida' => 6 }).allowed?(rules).should be_false
            end
          end
          context "true when" do
            it "<= max picks" do
              RadioSpot.new('Florida' => 5).allowed?(rules).should be_true
            end
          end         
        end
      end
    end
  end
end
