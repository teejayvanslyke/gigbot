module Gigbot
  class GigWriter
    def initialize(io)
      @io = io
    end

    attr_reader :io

    def write(gig)
      io.puts "job #{gig.id}".colorize(color: :yellow)
      io.puts "Title:  #{gig.title}"
      io.puts "URL:    #{gig.url}"
      io.puts "Source: #{gig.source_title}"
      io.puts "Date:   #{gig.created_at}"
      io.puts ""
    end

    def write_long(gig)
      write(gig)
      io.puts gig.description
    end
  end
end
