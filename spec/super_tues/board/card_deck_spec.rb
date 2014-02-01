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

      describe "default cards" do
        let(:cards) { CardDeck.new }
        it "all have a title" do
          cards.each { |card| expect(card.title).to_not be_nil }
        end
        it "all have a description" do
          cards.each { |card| expect(card.description).to_not be_nil }
        end
        it "all have an effect" do
          cards.each { |card| expect(card.effect).to_not be_nil }
        end
        it "none have a count" do
          cards.each { |card| expect(card.instance_variable_defined?(:@count)).to be_false }
        end
      end
    end

  end
end