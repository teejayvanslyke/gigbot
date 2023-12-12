require 'colorize'
require 'tty-pager'

require_relative '../gig'
require_relative '../gig_writer'

module Gigbot
  module Commands
    class List
      def self.run(options = {})
        new.run(options)
      end

      def run(options = {})
        formatter = options[:formatter] || Gigbot::Formatters::Short
        TTY::Pager.page do |pager|
          writer = GigWriter.new(pager, formatter)
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
end
