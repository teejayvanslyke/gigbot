require 'fileutils'

require_relative '../source'

module Gigbot
  module Commands
    class Update
      def self.run(options={})
        new.run(options)
      end

      def run(options={})
        puts "here"
        FileUtils.mkdir_p Gigbot::DATA_PATH
        Gigbot::Source.each do |source|
          begin
            source.import
            puts [
              "✓".colorize(color: :green),
              "(#{source.imported.length})".ljust(7, ' ').colorize(color: :yellow),
              source.title,
            ].join(' ')
          rescue StandardError => e
            if options[:verbose]
              puts e
              puts e.backtrace
            end
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
