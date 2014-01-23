require 'spec_helper'

module SuperTues
  module Game

    describe OpportunityDeck do
      let(:deck) { OpportunityDeck.new }
      specify { deck.should be_a Array }
    end

  end
end