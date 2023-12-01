require 'feedjira'
require 'open-uri'

module Gigbot
  module Parsers
    class RSS < Base
      def parse(url)
        URI.open(url) do |rss|
          feed = Feedjira.parse(rss.read)
          feed.entries.each do |rss_item|
            yield Gigbot::Gig.from_rss(rss_item)
          end
        end
      end
    end
  end
end
