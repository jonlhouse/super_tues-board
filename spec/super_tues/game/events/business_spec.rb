require 'spec_helper'

module SuperTues
  module Game
    module Events

      describe Business do
        specify { Business.should < Event }
      end
    
    end
  end
end