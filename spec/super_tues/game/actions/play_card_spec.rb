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
        end
      end
    end
  end
end
