require_relative './gig'
require 'colorize'
require 'tty-pager'
require_relative './gig_writer'

module Gigbot
  class Reader
    def self.run(options = {})
      new.run(options)
    end

    def run(options = {})
      TTY::Pager.page do |pager|
        writer = GigWriter.new(pager)
        if options[:since]
          Gig.since(options[:since]).each do |gig|
            writer.write(gig)
          end
        else
          Gig.all.each do |gig|
            writer.write(gig)
          end
        end
      end
    end
  end
end
