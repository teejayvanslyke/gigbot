require_relative './gig'
require 'colorize'

module Gigbot
  class Reader
    def self.run(options = {})
      new.run(options)
    end

    def print_gig(gig)
      puts gig.title.colorize(color: :blue, mode: :bold)
      puts gig.url.colorize(color: :yellow, mode: :underline)
      puts gig.created_at
      puts ""
    end

    def run(options = {})
      if options[:since]
        Gigbot::Gig.since(options[:since]).each do |gig|
          print_gig(gig)
        end
      else
        Gigbot::Gig.all.each do |gig|
          print_gig(gig)
        end
      end
    end
  end
end
