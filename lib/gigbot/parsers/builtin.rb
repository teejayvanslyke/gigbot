require 'time'
require 'open-uri'
require 'nokogiri'
require_relative '../helpers/date_helpers'

module Gigbot
  module Parsers
    class Builtin < Base
      include Gigbot::Helpers::DateHelpers

      def title
        "BuiltIn"
      end

      def parse
        URI.open(url) do |file|
          doc = Nokogiri::HTML(file)
          doc.css('[data-id="job-card"]').each do |card|
            yield parse_card(card)
          end
        end
      end

      def parse_card(card)
        title = card.css('h2 a').text.strip
        url = card.css('h2 a').attribute('href').value
        id = url
        date_css = 'div#main.row div.col-12.col-lg-6.bounded-attribute-section.d-flex.align-items-start.align-items-lg-center.fs-md.flex-column.flex-lg-row div.d-flex.flex-grow-1.gap-lg div.d-flex.flex-column.gap-0.flex-md-row.gap-md-md.flex-lg-column.gap-lg-0.fill-even div.d-flex.align-items-start.gap-sm span.font-barlow.text-gray-03'
        created_at = dehumanize_date(card.css(date_css).first.text.strip)

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
