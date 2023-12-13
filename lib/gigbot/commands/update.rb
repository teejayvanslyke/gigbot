require_relative '../source'

module Gigbot
  module Commands
    class Update
      def self.run
        new.run
      end

      def run
        Gigbot::Source.each do |source|
          begin
            source.import
            puts [
              "✓".colorize(color: :green),
              "(#{source.imported.length})".ljust(7, ' ').colorize(color: :yellow),
              source.title,
            ].join(' ')
          rescue StandardError => e
            puts [
              "X".colorize(color: :red),
              "".ljust(7, ' '),
              source.title,
            ].join(' ')
          end
        end
      end
    end
  end
end
