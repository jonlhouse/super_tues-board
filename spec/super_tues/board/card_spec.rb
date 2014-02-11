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

      describe "#to_h" do
        let(:attr_hash) { { title: 'Visit Sunny Florida', description: 'Play 3 picks in Texas\'s bin.', showing: false } }
        specify { expect(card.to_h).to eq(attr_hash) }
      end
    end

  end
end