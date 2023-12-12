module Gigbot
  module Parsers
    @registry = {}

    def self.register(name, klass)
      @registry[name] = klass
    end

    def self.[](name)
      @registry[name]
    end

    class Base
      def initialize(url)
        @url = url
      end

      attr_reader :url

      def title
        self.class.name
      end

      def parse
      end

      def parse_deep(gig)
      end
    end
  end
end
