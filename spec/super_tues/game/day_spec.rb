require 'spec_helper'

module SuperTues
  module Board

    describe Day do
      
      let(:simple_day) { Day.new(date: "2016-1-3", events: []) }
      specify { simple_day.date.should == Date.new(2016, 1, 3) }
      specify { simple_day.events.should be_a Array }

      # w/ events
      let(:primary_day) { Day.new(date: "2016-1-18", events: [ { primary: { state: 'Iowa' } } ] ) }
      specify { primary_day.events.first.should be_a Events::Primary }

    end

  end
end