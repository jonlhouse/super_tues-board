require 'spec_helper'

module SuperTues
  module Board

    describe Day do
      
      let(:simple_day) { Day.new(date: "2016-1-3", events: []) }
      specify { simple_day.date.should == Date.new(2016, 1, 3) }
      specify { simple_day.events.should be_a Array }

      describe "events as" do
        context "a hash" do
          subject { Day.new(date: "2016-1-18", events: { 
            primary: { state: 'Iowa' },
            business: {},
            vote_bill: {},
            rent: { cost: 2 }
          } ).events }
          its(:first) { should be_a Events::Primary }
          its(:last) { should be_a Events::Rent }
        end
        context "an array" do
          subject { Day.new(date: "2016-1-18", events: [
            { primary: { state: 'South Carolina' } },
            { primary: { state: 'Florida' } },
            { business: {} },
            { vote_bill: {} },
            { rent: { cost: 2 } }
          ] ).events }
          its('first.state') { should be == 'South Carolina' }
          it { subject[1].state.should be == 'Florida' }
          its('last') { should be_a Events::Rent }
        end
      end
      

    end

  end
end