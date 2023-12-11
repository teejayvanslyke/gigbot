require 'feedjira'
require 'open-uri'

module Gigbot
  module Parsers
    class RSS < Base
      def open_uri(&block)
        URI.open(url, read_timeout: 10, &block)
      end

      def title
        @title ||= Feedjira.parse(open_uri.read).title
      end

      def parse
        open_uri do |rss|
          feed = Feedjira.parse(rss.read)
          feed.entries.each do |rss_item|
            yield Gigbot::Gig.from_rss(rss_item)
          end
        end
      end
    end
  end
end

Gigbot::Parsers.register('rss', Gigbot::Parsers::RSS)
