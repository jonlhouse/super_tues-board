require 'spec_helper'

module SuperTues
  module Board
    module Actions
      describe Poll do
        specify { Poll.should < Action }

        describe "initialize" do
          specify { Poll.new('Indiana').instance_variable_get(:@states).should == ['Indiana'] }
        end

        describe "#allowed?" do
          let(:rules) { Game.new.tap { |b| b.stub(current_player: 'p1') }.rules }
          context "true when" do
            it "under max allowed" do
              Poll.new('Indiana').allowed?(rules).should be
            end
          end
          context "false when" do
            describe "over max allowed" do
              specify { Poll.new('Indiana', 'Illinois').allowed?(rules).should_not be }

              it "unless rules allow" do
                new_rules = rules.ammend 'action.poll.max', 2, player: :current
                Poll.new('Indiana', 'Illinois').allowed?(new_rules).should be
              end
            end            
          end
        end

      end
    end
  end
end
