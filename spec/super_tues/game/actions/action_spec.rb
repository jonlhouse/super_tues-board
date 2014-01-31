require 'spec_helper'

module SuperTues
  module Board
    module Actions

      describe Action do
        describe ".build" do
          specify { Action.should respond_to :build }
          [ 'radio_spot', 'political_favor', 'move', 'play_cards', 'discard', 'poll', 'pass'].each do |klass|
            specify { Action.build(klass).should 
                be_a SuperTues::Board::Actions.const_get(klass.camelcase) }
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
            specify { Action.new.allowed?(nil).should be }
          end
        end

      end

    end
  end
end