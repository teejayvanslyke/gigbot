require_relative './source'

module Gigbot
  class Updater
    def self.run
      new.run
    end

    def run
      Gigbot::Source.each do |source|
        source.import
        puts "✓ #{source.url}".colorize(color: :green)
      end
    end
  end
end


