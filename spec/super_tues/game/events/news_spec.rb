require 'spec_helper'

module SuperTues
  module Game
    module Events

      describe News do
        specify { News.should < Event }
      end

    end
  end
end