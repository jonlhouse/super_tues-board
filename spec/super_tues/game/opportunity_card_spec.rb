require 'spec_helper'

module SuperTues
  module Game

    describe OpportunityCard do
      let(:card) { OpportunityCard.new(
        title: 'Visit Sunny Florida', 
        description: 'Play 3 picks in Texas\'s bin.',
        effect: {
          player: :current,
          action: {
            play_picks: 3,
            where: 'Texas'
          }

        }
      )}

      specify { card.title.should == 'Visit Sunny Florida' }
      specify { card.description.should == 'Play 3 picks in Texas\'s bin.' }
      specify { card.effect.should be_a Hash }
    end

  end
end