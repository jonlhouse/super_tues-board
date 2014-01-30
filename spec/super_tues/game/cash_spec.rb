require 'spec_helper'

module SuperTues
  module Game
    describe Cash do

      describe "equality" do
        specify { Cash.new(1).should == 1 }
        specify { 1.should == Cash.new(1) }
      end

      describe "#to_s" do
        specify { Cash.new(10).to_s.should == '$100k' }
        specify { Cash.new(0).to_s.should == '$0k' }
      end

      describe "#+" do
        specify { (Cash.new(1) + 2).should == Cash.new(3) }
      end

      describe "#-" do
        specify { (Cash.new(2) - 1).should == Cash.new(1) }
      end
    end
  end
end