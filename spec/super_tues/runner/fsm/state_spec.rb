require 'spec_helper'

module SuperTues
  module Runner
    module FSM

      describe State do

        subject { State.new(:begin) }

        describe "#name" do
          its(:name) { should be == :begin }
        end
      end

    end
  end
end