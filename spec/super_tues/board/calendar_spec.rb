require 'spec_helper'

module SuperTues
  module Board
    describe Calendar do
      
      let(:d0) { double('d0') }
      let(:d1) { double('d1') }
      let(:d2) { double('d2') }
      let(:days) { [d0, d1, d2] }      
      let!(:calendar) { Calendar.new.tap { |c| c.days = days } }

      subject { calendar }
      its(:days) { should == days }
      
      describe "#today and #today=" do
        it "initializes with" do
          expect(calendar.today).to be_nil
        end
        it "gets/sets" do
          subject.today = d0
          expect(subject.today).to be == d0
        end
        it "is indexed" do
          subject.today = 1
          expect(subject.today).to be == d1
        end        
      end

      describe "#tomorrow!" do
        specify { expect { calendar.tomorrow! }.to change { calendar.today }.from(nil).to(d0) }
        specify { expect { calendar.tomorrow! ; calendar.tomorrow! }.to change { calendar.today }.from(nil).to(d1) }
      end

      describe "is observable" do
        it "notifies when days change" do
          called = false
          calendar.add_observer do
            called = true
          end
          calendar.tomorrow!
          expect(called).to be_true
        end
      end

    end
  end
end