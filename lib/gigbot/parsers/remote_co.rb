require 'time'
require 'open-uri'
require 'nokogiri'
require_relative '../helpers/date_helpers'
require_relative '../helpers/string_helpers'

module Gigbot
  module Parsers
    class RemoteCo < Base
      include Gigbot::Helpers::DateHelpers
      include Gigbot::Helpers::StringHelpers

      def title
        "Remote.co"
      end

      def parse
        URI.open(url) do |file|
          doc = Nokogiri::HTML(file)
          doc.css('.card-body a.card.m-0').each do |card|
            yield parse_card(card)
          end
        end
      end

      def parse_card(card)
        title = card.css('p.m-0 .font-weight-bold').text.strip
        url = 'https://remote.co' + card.attribute('href').value.strip
        id = url
        created_at = dehumanize_date(card.css('date').first.text.strip)

        {
          title: title,
          url: url,
          created_at: created_at,
        }
      end

      def parse_deep(gig)
        URI.open(gig.url) do |file|
          doc = Nokogiri::HTML(file)
          description = textify_html_summary(doc.css(".job_description").first.inner_html)
          return { description: description }
        end
      end
    end
  end
end

Gigbot::Parsers.register('remote.co', Gigbot::Parsers::RemoteCo)
