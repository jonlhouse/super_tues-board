require 'spec_helper'

module SuperTues
  module Game
    module Events

      describe Business do
        let(:actions) { Business.new }
        specify { actions.should respond_to :happen }
      end
    
    end
  end
end