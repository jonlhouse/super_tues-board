require 'spec_helper'

module SuperTues
  module Board

    describe NewsDeck do
      specify { NewsDeck.should < Deck }

      context "when initialized" do
        let(:deck) { NewsDeck.new }
        specify { deck.should_not be_empty }
        specify { deck.each { |news| news.should be_a News } }
        it "should be suffled" do
          NewsDeck.any_instance.should_receive :shuffle!
          NewsDeck.new
        end
      end      
    end

  end
end