require 'spec_helper'

module SuperTues
  module Game
    module Actions
      describe PlayCards do
        specify { PlayCards.should < Action }

        let(:card) { double(title: '', description: '', effect: {}) }

        describe "initialize" do
          specify { PlayCards.new(card).instance_variable_get(:@cards).should == [card] }
        end

        describe "#allowed?" do
          let(:rules) { Board.new.rules }
          context "true when" do
            specify { PlayCards.new(card).allowed?(rules).should be }
            it "more than one card played when rules allow" do

            end
          end
          context "false when" do
            specify { 
              # rules.ammend 'player.can_play_picks', false, player: :current
              new_rules = rules.ammend 'action.play_cards.allowed', false, player: :current
              PlayCards.new(card).allowed?(new_rules).should_not be 
            }
          end
        end
      end
    end
  end
end
