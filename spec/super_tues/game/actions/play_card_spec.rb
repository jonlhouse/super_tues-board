require 'spec_helper'

module SuperTues
  module Game
    module Actions
      describe PlayCard do
        specify { PlayCard.should < Action }
      end
    end
  end
end
