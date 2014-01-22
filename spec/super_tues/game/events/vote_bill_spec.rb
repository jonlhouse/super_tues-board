require 'spec_helper'

module SuperTues
  module Game
    module Events

      describe VoteBill do
        let(:vote_bill) { VoteBill.new }
        specify { vote_bill.should respond_to :happen }
      end

    end
  end
end