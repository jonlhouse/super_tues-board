require 'spec_helper'

module SuperTues
  module Board

    describe Card do
      let(:card) { Card.new(
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
      specify { card.up?.should_not be }
      specify { card.down?.should be }
      specify { expect { card.show }.to change { card.up? } }

    end

  end
end