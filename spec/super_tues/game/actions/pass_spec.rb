require 'spec_helper'

module SuperTues
  module Game
    module Actions
      describe Poll do
        specify { Pass.should < Action }

        describe "allowed?" do
          let(:rules) { Board.new.rules }
          context "true when" do
            specify { Pass.new.allowed?(rules).should be }
          end
        end
      end
    end
  end
end
