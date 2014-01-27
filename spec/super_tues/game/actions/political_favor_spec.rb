require 'spec_helper'

module SuperTues
  module Game
    module Actions
      describe PoliticalFavor do
        specify { PoliticalFavor.should < Action }
      end
    end
  end
end
