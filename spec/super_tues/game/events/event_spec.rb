require 'spec_helper'

module SuperTues
  module Game
    module Events
      describe Event do
        
        describe ".build" do
          specify { Event.build("read_bill").should be_a ReadBill }
        end

      end
    end
  end
end