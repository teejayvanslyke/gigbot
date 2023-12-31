require 'feedjira'
require 'open-uri'

module Gigbot
  module Parsers
    class RSS < Base
      include Gigbot::Helpers::StringHelpers

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
            yield({
              title: rss_item.title.strip,
              url: rss_item.url.strip,
              description: textify_html_summary(rss_item.summary&.strip),
              created_at: rss_item.published,
            })
          end
        end
      end
    end
  end
end

Gigbot::Parsers.register('rss', Gigbot::Parsers::RSS)
