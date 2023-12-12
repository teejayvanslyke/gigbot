module Gigbot
  module Commands
    class Deep
      def run
      end

      def self.run
        Gigbot::Gig.each do |gig|
          gig.source.import_deep(gig)
          puts gig.to_s
        end
      end
    end
  end
end
