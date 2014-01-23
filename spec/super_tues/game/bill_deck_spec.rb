require 'spec_helper'

module SuperTues
  module Game

    describe BillDeck do
      specify { BillDeck.should < Deck }

      describe "when initialized" do
        let(:bill_deck) { BillDeck.new }
        specify { bill_deck.should_not be_empty }
        specify { bill_deck.each { |bill| bill.should be_a Bill } }
        it "is shuffled" do
          BillDeck.any_instance.should_receive :shuffle!
          BillDeck.new
        end
      end
      
    end

  end
end