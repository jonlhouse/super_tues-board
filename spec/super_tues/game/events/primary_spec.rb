require 'spec_helper'

module SuperTues
  module Game
    module Events

      describe Primary do
        let(:primary) { Primary.new(state: 'Iowa') }
        specify { primary.should respond_to :happen }
      end

    end
  end
end