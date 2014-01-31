module SuperTues
  module Board

    class Bill

      attr_reader :title, :description, :action, :votes

      def initialize(attrs)
        @title = attrs[:title]
        @description = attrs[:description]
        @action = attrs[:action]
        @votes = attrs[:votes]
      end

    end

  end
end