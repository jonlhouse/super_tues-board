require 'spec_helper'

module SuperTues
  module Board
    describe Cash do

      describe "equality" do
        specify { Cash.new(1).should == 1 }
        specify { 1.should == Cash.new(1) }
      end

      describe "#to_s" do
        specify { expect(Cash.new(1).to_s).to be == '$100k' }
        specify { expect(Cash.new(10).to_s).to be == '$1,000k' }
        specify { expect(Cash.new(0).to_s).to be == '$0k' }
      end

      describe "#+" do
        specify { (Cash.new(1) + 2).should == Cash.new(3) }
      end

      describe "#-" do
        specify { (Cash.new(2) - 1).should == Cash.new(1) }
      end

      describe "to_json" do
        specify { expect(Cash.new(5).to_json).to be == '5' }
      end
    end
  end
end