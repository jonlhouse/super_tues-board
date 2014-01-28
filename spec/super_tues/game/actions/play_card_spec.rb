require 'spec_helper'

module SuperTues
  module Game
    module Actions
      describe PlayCard do
        specify { PlayCard.should < Action }

        let(:card) { double(title: '', description: '', effect: {}) }

        describe "initialize" do
          specify { PlayCard.new(card).instance_variable_get(:@card).should == card }
        end

        describe "#allowed?" do
          let(:rules) { Board.new.rules }
          context "true when" do
            specify { PlayCard.new(card).allowed?(rules).should be }
          end
          context "false when" do
            specify { 
              # rules.ammend 'player.can_play_picks', false, player: :current
              new_rules = rules.ammend 'player.can_play_cards', false, player: :current
              PlayCard.new(card).allowed?(new_rules).should_not be 
            }
          end
        end
      end
    end
  end
end
