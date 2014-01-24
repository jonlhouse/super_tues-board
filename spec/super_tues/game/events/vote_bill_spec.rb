require 'spec_helper'

module SuperTues
  module Game
    module Events

      describe VoteBill do
        specify { VoteBill.should < Event }
      end

    end
  end
end