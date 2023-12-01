require_relative './source'

module Gigbot
  class Updater
    def self.run
      new.run
    end

    def run
      Gigbot::Source.each do |source|
        source.import
        puts [
          "✓".colorize(color: :green),
          "(#{source.imported.length})".ljust(7, ' ').colorize(color: :yellow),
          source.url.colorize(color: :blue)
        ].join(' ')
      end
    end
  end
end


