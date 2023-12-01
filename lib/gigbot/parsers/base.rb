module Gigbot
  module Parsers
    class Base
      def self.parse(url)
        new.parse(url)
      end
    end
  end
end
