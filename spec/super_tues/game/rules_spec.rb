require 'spec_helper'

module SuperTues
  module Game

    describe Rules do

      describe "default" do
        specify { Rules.default.should be_a Rules }
      end
    end

  end
end
