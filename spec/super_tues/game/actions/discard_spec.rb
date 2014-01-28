require 'spec_helper'

module SuperTues
  module Game
    module Actions
      describe Discard do
        specify { Discard.should < Action }

        let(:card) { double(title: '', description: '', effects: {}) }

        describe "initialize" do
          specify { Discard.new(card).instance_variable_get(:@cards).should == [card] }
        end

        describe "#allowed?" do
          let(:rules) { Board.new.rules }
          context "true when" do
            specify { Discard.new(card).allowed?(rules).should be }
            it "more than one card discarded when rules allow" do
              new_rules = rules.ammend 'action.discard.max', 2, player: :all
              Discard.new(card, card).allowed?(rules).should be
            end
          end
          context "false when" do
            specify { 
              new_rules = rules.ammend 'action.discard.allowed', false, player: :current
              Discard.new(card).allowed?(new_rules).should_not be 
            }
            it "more than one card played" do
              Discard.new(card, card).allowed?(rules).should_not be
            end
          end
        end

      end
    end
  end
end
