require 'spec_helper'

module SuperTues
  module Game

    describe Day do
      
      let(:day) { Day.new(date: "2016-1-3", events: []) }
      specify { day.date.should == Date.new(2016, 1, 3) }
      specify { day.events.should be_a Array }

    end

  end
end