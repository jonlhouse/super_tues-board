module SuperTues
  module Game
   
    class News
      attr_reader :title, :description, :actions

      def initialize(attrs)
        @title = attrs[:title]
        @description = attrs[:description]
        @actions = attrs[:actions]
      end

    end

  end
end