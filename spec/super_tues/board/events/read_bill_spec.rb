require 'spec_helper'

module SuperTues
  module Board
    module Events

      describe ReadBill do
        specify { ReadBill.should < Event }
      end

    end
  end
end