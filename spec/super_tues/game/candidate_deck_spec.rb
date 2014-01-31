require 'spec_helper'

module SuperTues
  module Board

    describe CandidateDeck do
      specify { CandidateDeck.should < Deck }

      context "when initialized" do
        let(:candidates) { CandidateDeck.new }
        specify { candidates.should_not be_empty }
        specify { candidates.each { |c| c.should be_a Candidate }}
        it "should be suffled" do
          CandidateDeck.any_instance.should_receive :shuffle!
          CandidateDeck.new
        end
      end
    end   

  end
end