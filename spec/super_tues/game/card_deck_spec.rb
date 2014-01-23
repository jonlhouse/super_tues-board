require 'spec_helper'

module SuperTues
  module Game

    describe CardDeck do
      let(:deck) { CardDeck.new }
      specify { deck.should be_a Array }
    end

  end
end