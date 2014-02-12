require 'spec_helper'

module SuperTues
  module Runner
    module FSM

      describe Specification do

        let(:spec) {
          Specification.new initial_state: :waiting_for_players do |spec|

            event :join do
              transition :waiting_for_players => :new_or_load, if: :last_player?
              transition :waiting_for_players => :waiting_for_players, unless: :last_player?              
            end

            event :new_game do
              transition :new_or_load => :picking_candidates              
            end

            event :load_game do
              transition :new_or_load => :waiting_to_start
            end

            event :candidate_picked do
              transition :picking_candidates => :waiting_to_start, if: :candidates_all_picked?
              transition :picking_candidates => :picking_candidates, unless: :candidates_all_picked?
            end

            event :start do
              transition :waiting_to_start => :current_turn
            end

          end
        }

        describe "transitions" do
          describe "legal transition" do
            it "goes from one state to another" do
              expect { spec.join }.
                  to change { spec.current_state }.from(:waiting_for_players).to(:waiting_for_players)
            end
          end
        end

      end

    end
  end
end