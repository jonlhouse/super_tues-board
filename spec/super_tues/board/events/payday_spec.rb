require 'spec_helper'

module SuperTues
  module Board
    module Events
      describe Payday do
        specify { Payday.should < Event }
      end
    end
  end
end
