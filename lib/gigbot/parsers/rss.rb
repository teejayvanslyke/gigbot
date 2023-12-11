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

      def textify_html_summary(summary)
        IO.popen("w3m -T text/html -dump -cols 80", mode="r+") do |io|
          io.write(summary)
          io.close_write
          return io.read
        end
      end

      def gig_from_rss(rss_item)
        Gigbot::Gig.new(
          id: Gigbot::Gig.generate_id(rss_item.id),
          title: rss_item.title.strip,
          url: rss_item.url.strip,
          description: textify_html_summary(rss_item.summary&.strip),
          created_at: rss_item.published
        )
      end

      def parse
        open_uri do |rss|
          feed = Feedjira.parse(rss.read)
          feed.entries.each do |rss_item|
            yield gig_from_rss(rss_item)
          end
        end
      end
    end
  end
end

Gigbot::Parsers.register('rss', Gigbot::Parsers::RSS)
