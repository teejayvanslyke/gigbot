require 'time'
require 'open-uri'
require 'nokogiri'
require_relative '../helpers/date_helpers'

module Gigbot
  module Parsers
    class RemoteCo
      include Gigbot::Helpers::DateHelpers

      def self.parse(url)
        new.parse(url)
      end

      def parse(url)
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

        Gigbot::Gig.new(
          title: title,
          url: url,
          id: Gigbot::Gig.generate_id(id),
          created_at: created_at
        )
      end
    end
  end
end
