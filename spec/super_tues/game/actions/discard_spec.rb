require 'spec_helper'

module SuperTues
  module Game
    module Actions
      describe Discard do
        specify { Discard.should < Action }
      end
    end
  end
end
