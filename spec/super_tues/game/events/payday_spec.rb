require 'spec_helper'

module SuperTues
  module Game
    module Events
      describe Payday do
        specify { Payday.should < Event }
      end
    end
  end
end
