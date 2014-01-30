require 'spec_helper'

module SuperTues
  module Game
    describe StateBin do

      it { StateBin.should < Hash }

      describe "#[]" do
        let(:bin) { StateBin[red: 42] }
        specify { bin[:red].should == 42 }
        specify { bin[double(to_sym: :red)].should == 42 }
      end

      describe "#[]=" do        
        it "call to_sym on keys" do
          bin = StateBin.new
          bin[:red] = 42
          bin[double(to_sym: :red)].should == 42
        end
      end

    end
  end
end