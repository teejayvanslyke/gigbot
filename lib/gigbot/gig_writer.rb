require_relative './formatters/short'

module Gigbot
  class GigWriter
    def initialize(io, formatter_class)
      @io = io
      @formatter_class = formatter_class
    end

    attr_reader :io, :formatter_class

    def write(gig)
      io.puts formatter_class.new(gig).to_s
      io.puts ""
    end
  end
end
