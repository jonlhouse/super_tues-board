require 'spec_helper'

module SuperTues
  module Game
    module Actions

      describe Action do
        describe ".build" do
          specify { Action.should respond_to :build }
          [ 'radio_spot', 'political_favor', 'move', 'play_card', 'discard', 'poll'].each do |klass|
            specify { Action.build(klass).should 
                be_a SuperTues::Game::Actions.const_get(klass.camelcase) }
          end
        end

        describe "API functions" do
          let(:board) { nil }
          describe "#perform(board)" do
            specify { Action.new.should respond_to :perform }
            specify { expect { Action.new.perform(board) }.to raise_error NotImplementedError }
          end

          describe "#cost(board)" do
            specify { Action.new.should respond_to :cost }
            specify { expect { Action.new.cost(board) }.to raise_error NotImplementedError }          
          end

          describe "#allowed?(board)" do
            specify { Action.new.should respond_to :allowed? }
            specify { expect { Action.new.allowed?(board) }.to raise_error NotImplementedError }          
          end
        end

      end

    end
  end
end