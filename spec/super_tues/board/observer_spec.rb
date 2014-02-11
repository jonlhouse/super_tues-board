require 'spec_helper'

class TestClass
  include SuperTues::Board::Observer

  def happen
    notify_observers
  end
end

module SuperTues
  module Board

    describe "Observer" do
      let(:test) { TestClass.new }

      describe "#add_observer" do
        it "adds to list of observers" do
          test.add_observer { }
          expect(test.instance_variable_get(:@observers).length).to be > 0
        end
      end

      describe "#remove_observer" do
        it "removes based on the observer id" do
          o1 = test.add_observer { }
          o2 = test.add_observer { }
          expect { test.remove_observer(o1) }.to change { 
            test.instance_variable_get(:@observers).length 
            }.from(2).to(1)
        end
      end

      describe "calls block when notified" do
        it "calls the callback" do
          local_var = 0
          test.add_observer { local_var = local_var + 1 }
          expect { test.happen }.to change { local_var }.from(0).to(1)
        end
      end
    end

  end
end