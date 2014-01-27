require 'spec_helper'

module SuperTues
  module Game
    module Actions

      describe Action do
        describe ".build" do
          specify { Action.should respond_to :build }
          [ 'radio_spot', 'political_favor', 'move', 
            'play_card', 'discard', 'poll'].each do |klass|
              specify { Action.build(klass).should 
                  be_a SuperTues::Game::Actions.const_get(klass.camelcase) }
          end
        end

      end

    end
  end
end