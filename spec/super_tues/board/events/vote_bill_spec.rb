require 'spec_helper'

module SuperTues
  module Board
    module Events

      describe VoteBill do
        specify { VoteBill.should < Event }
      end

    end
  end
end