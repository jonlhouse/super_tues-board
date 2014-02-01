require 'spec_helper'

module SuperTues
  module Board
    module Events

      describe Primary do

        let(:primary) { Primary.new(state: 'Iowa') }
        subject { primary }

        describe "#to_s" do
          its(:to_s) { should match /iowa state primary/i }          
        end
      end

    end
  end
end