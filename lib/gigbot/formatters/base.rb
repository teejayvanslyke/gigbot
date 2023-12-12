module Gigbot
  module Formatters
    class Base
      def initialize(gig)
        @gig = gig
      end

      attr_reader :gig

      def to_s
        gig.to_s
      end
    end
  end
end
