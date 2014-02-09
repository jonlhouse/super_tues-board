require 'spec_helper'

module SuperTues
  module Board
    describe Clout do

      describe ".new" do
        specify { Clout.new(10).should be_a Clout }
      end

      describe "#==" do
        specify { Clout.new(10).should == Clout.new(10) }
        specify { Clout.new(10).should == 10 }
      end

      describe "#+" do
        specify { (Clout.new(10) + 10).should == 20 }
        specify { (Clout.new(-10) + 10).should == Clout.new(0) }
      end

      describe "#-" do
        specify { (Clout.new(10) - 5).should == 5 }
        specify { (Clout.new(5) - 10).should == Clout.new(-5) }
      end

      describe "to_json" do
        specify { expect(Clout.new(5).to_json).to be == '5' }
      end
    end
  end
end