module Gigbot
  module Parsers
    class Base
      def initialize(url)
        @url = url
      end

      attr_reader :url

      def title
        self.class.name
      end
    end
  end
end
