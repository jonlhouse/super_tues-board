require 'spec_helper.rb'

module SuperTues
  module Board

    describe Candidate do

      candidate_attributes = { 
        name: 'Old Senator Barnes', cash: 80, clout: 20, cards: 2, state: 'NH', special: '', description: 'Extra info.' 
      }
      let(:candidate) { Candidate.new(candidate_attributes) }

      describe "attributes set via initial hash" do        
        candidate_attributes.keys.each do |attr|
          it "sets #{attr}" do
            candidate.send(attr).should == candidate_attributes[attr]
          end
        end
      end

      describe "to_json" do        
        specify { expect(candidate.to_h).to be == candidate_attributes }
      end

    end

  end
end 