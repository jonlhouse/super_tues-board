require 'spec_helper'

module SuperTues
  module Board
    module Actions
      describe Poll do
        specify { Pass.should < Action }

        describe "allowed?" do
          let(:rules) { Game.new.rules }
          context "true when" do
            specify { Pass.new.allowed?(rules).should be }
          end
        end
      end
    end
  end
end
