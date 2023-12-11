require_relative './source'

module Gigbot
  class Updater
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
            source.parser.title.colorize(color: :blue)
          ].join(' ')
        rescue Exception => e
          puts [
            "X".colorize(color: :red),
            "(X)".ljust(7, ' ').colorize(color: :red),
            source.url.colorize(color: :red),
            e,
          ].join(' ')
        end
      end
    end
  end
end


