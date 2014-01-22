require 'spec_helper'

module SuperTues
  module Game

    describe Day do
      
      let(:day) { Day.new(date: "2016-1-3") }
      specify { day.date.should == Date.new(2016, 1, 3) }

    end

  end
end