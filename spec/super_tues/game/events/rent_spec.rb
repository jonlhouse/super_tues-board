require 'spec_helper'

module SuperTues
  module Game
    module Events

      describe Rent do
        let(:rent) { Rent.new(cost: 1) }
        specify { rent.should respond_to :happen }
      end

    end
  end
end