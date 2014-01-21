require 'spec_helper.rb'

module SuperTues
  module Game

    describe Candidate do

      describe "attributes set via initial hash" do
        candidate_attributes = { 
          name: 'Old Senator Barnes', clout: 20, cash: 80, cards: 2, description: 'Extra info.' 
        }
        let(:candidate) { Candidate.new(candidate_attributes) }
        candidate_attributes.keys.each do |attr|
          it "sets #{attr}" do
            candidate.send(attr).should == candidate_attributes[attr]
          end
        end
      end

      describe "is described in a yaml file" do

      end

    end

  end
end 