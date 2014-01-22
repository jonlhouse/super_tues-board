require 'spec_helper'

module SuperTues
  module Game
    module Events

      describe ReadBill do
        let(:read_bill) { ReadBill.new }
        specify { read_bill.should respond_to :happen }
      end

    end
  end
end