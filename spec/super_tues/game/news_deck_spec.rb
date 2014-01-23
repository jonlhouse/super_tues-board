require 'spec_helper'

module SuperTues
  module Game

    describe NewsDeck do
      let(:news_deck) { NewsDeck.new }
      specify { news_deck.should be_a Array }
    end

  end
end