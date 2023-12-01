require 'feedjira'
require 'open-uri'

module Gigbot
  module Parsers
    class RSS < Base
      def parse(url)
        URI.open(url) do |rss|
          feed = Feedjira.parse(rss.read)
          feed.entries.each do |rss_item|
            gig = Gigbot::Gig.from_rss(rss_item)
            gig.save
          end
        end
      end
    end
  end
end
