require 'spec_helper'

module SuperTues
  module Board

    describe CardDeck do
      specify { CardDeck.should < Deck }

      context "when initialized" do
        let(:deck) { CardDeck.new }
        specify { deck.should_not be_empty }
        specify { deck.each { |card| card.should be_a Card } }
        it "should be shuffled" do
          CardDeck.any_instance.should_receive :shuffle!
          CardDeck.new
        end
      end
    end

  end
end