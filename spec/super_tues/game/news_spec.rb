require 'spec_helper'

module SuperTues
  module Game

    describe News do
      let(:news) { News.new(
        title: 'USA Today Polls New York',
        description: "Reveal New York's picks.  The current leader gains 7 clout.",
        actions: [
          reveal: { what: 'picks', where: 'New York', to: 'all' },
          award: { clout: 7, to: { state_frontrunner: 'New York' } }
        ]
      )}
      specify { news.title.should == 'USA Today Polls New York' }
      specify { news.description.should_not be_blank }
      specify { news.actions.should be_a Array }
    end

  end
end