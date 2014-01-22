require 'spec_helper'

module SuperTues
  module Game
    module Events
      describe Payday do

        let(:payday) { Payday.new }
        specify { payday.should respond_to :happen }

      end
    end
  end
end
