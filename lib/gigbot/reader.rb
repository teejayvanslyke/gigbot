require_relative './gig'
require 'colorize'
require 'tty-pager'

module Gigbot
  class Reader
    def self.run(options = {})
      new.run(options)
    end

    def print_gig(pager, gig)
      pager.puts "job #{gig.id}".colorize(color: :yellow)
      pager.puts "Title:  #{gig.title}"
      pager.puts "URL:    #{gig.url}"
      pager.puts "Source: #{gig.source_title}"
      pager.puts "Date:   #{gig.created_at}"
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
