require 'spec_helper'

module SuperTues
  module Board
    module Events

      describe Business do
        specify { Business.should < Event }
      end
    
    end
  end
end