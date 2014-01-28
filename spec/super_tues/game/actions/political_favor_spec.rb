require 'spec_helper'

module SuperTues
  module Game
    module Actions

      describe PoliticalFavor do
        specify { PoliticalFavor.should < PlayPicks }

        describe "#initialize(params)" do
          attrs = { 'Iowa' => 5 }
          favor = PoliticalFavor.new attrs
          favor.instance_variable_get(:@state_picks).should == attrs
        end

        describe "#allowed?" do
          let(:rules) { Board.new.rules }
          context "true when" do
            it "total picks <= max" do
              PoliticalFavor.new('Iowa' => 5).allowed?(rules).should be
            end
          end
          context "false when" do
            it "total picks < 1" do
              PoliticalFavor.new('Iowa' => 0).allowed?(rules).should_not be
            end
            it "total picks > max" do
              PoliticalFavor.new('Iowa' => 6).allowed?(rules).should_not be
            end
          end         
        end

      end      
    end

  end
end
