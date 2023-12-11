require_relative './gig'
require 'colorize'
require 'tty-pager'

module Gigbot
  class Reader
    def self.run(options = {})
      new.run(options)
    end

    def print_gig(pager, gig)
      pager.puts gig.title.colorize(color: :blue, mode: :bold)
      pager.puts gig.url.colorize(color: :yellow, mode: :underline)
      pager.puts gig.source_title.colorize(color: :green)
      pager.puts gig.created_at
      pager.puts gig.description
      pager.puts ""
    end

    def run(options = {})
      TTY::Pager.page do |pager|
        if options[:since]
          Gigbot::Gig.since(options[:since]).each do |gig|
            print_gig(pager, gig)
          end
        else
          Gigbot::Gig.all.each do |gig|
            print_gig(pager, gig)
          end
        end
      end
    end
  end
end
