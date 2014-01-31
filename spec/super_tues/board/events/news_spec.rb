require 'spec_helper'

module SuperTues
  module Board
    module Events

      describe News do
        specify { News.should < Event }
      end

    end
  end
end