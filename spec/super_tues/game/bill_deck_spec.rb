require 'spec_helper'

module SuperTues
  module Game

    describe BillDeck do
      specify { BillDeck.should < Deck }
    end

  end
end