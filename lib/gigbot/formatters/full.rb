require_relative './base'
require_relative './short'

module Gigbot
  module Formatters
    class Full < Base
      def to_s
        [
          Short.new(gig).to_s,
          "",
          gig.description
        ].join("\n")
      end
    end
  end
end

