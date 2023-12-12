require_relative '../gig_writer'
require_relative '../formatters/full'

module Gigbot
  module Commands
    class Show
      def self.run(sha)
        new.run(sha)
      end

      def run(sha)
        TTY::Pager.page do |pager|
          writer = GigWriter.new(pager, Gigbot::Formatters::Full)
          gig = Gig.find(sha)
          writer.write(gig)
        end
      end
    end
  end
end
