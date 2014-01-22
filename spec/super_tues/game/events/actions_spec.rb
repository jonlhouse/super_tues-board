require 'spec_helper'

module SuperTues
  module Game
    module Events

      describe Actions do
        let(:actions) { Actions.new }
        specify { actions.should respond_to :happen }
      end
    
    end
  end
end