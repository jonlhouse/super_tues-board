require 'spec_helper'

module SuperTues
  module Board
    describe Calendar do
      
      let(:d0) { double('d0') }
      let(:d1) { double('d1') }
      let(:d2) { double('d2') }
      let(:days) { [d0, d1, d2] }      
      let!(:calendar) { Calendar.new.tap { |c| c.days = days ; c.today = 0 } }

      subject { calendar }
      its(:days) { should == days }
      
      describe "#today and #today=" do
        specify { subject.today = d0 ; expect(subject.today).to be == d0 }
        specify { subject.today = 1 ; expect(subject.today).to be == d1 }
      end

      describe "#tomorrow!" do
        specify { expect { calendar.tomorrow! }.to change { calendar.today }.from(d0).to(d1) }
      end

    end
  end
end