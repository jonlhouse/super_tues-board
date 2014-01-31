require 'spec_helper'

module SuperTues
  module Board

    describe Bill do
      let(:bill) { Bill.new(
        title: 'Campaign Finance Reform',
        description: "If passed, each candidate's payday is reduced by $300K.",
        votes: { clout: 6, voting: 'aye' },
        action: {
          candidate_change: {
            duration: 'forever',
            target: 'all',
            payday: { cash: '-3' }
          }
        }

      )}
      specify { bill.title.should == 'Campaign Finance Reform' }
      specify { bill.description.should be_present }
      specify { bill.votes.keys.to_set.should == [:clout, :voting].to_set }
      specify { bill.action.should be_present }
    end

  end
end