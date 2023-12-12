require_relative '../gig_writer'

module Gigbot
  module Commands
    class Show
      def self.run(sha)
        new.run(sha)
      end

      def run(sha)
        TTY::Pager.page do |pager|
          writer = GigWriter.new(pager)
          gig = Gig.find(sha)
          writer.write_long(gig)
        end
      end
    end
  end
end
