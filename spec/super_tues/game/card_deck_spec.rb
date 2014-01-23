require 'spec_helper'

module SuperTues
  module Game

    describe CardDeck do
      specify { CardDeck.should < Deck }
    end

  end
end