require 'time'
require 'open-uri'
require 'nokogiri'
require_relative '../helpers/date_helpers'

module Gigbot
  module Parsers
    class FlexJobs < Base
      include Gigbot::Helpers::DateHelpers

      def title
        "FlexJobs"
      end

      def parse
        URI.open(url) do |file|
          doc = Nokogiri::HTML(file)
          doc.css('li.job').each do |card|
            yield parse_card(card)
          end
        end
      end

      def parse_card(card)
        title = card.attribute('data-title').value
        url = 'https://www.flexjobs.com' + card.attribute('data-url').value
        id = url
        date = card.css('.job-age').first.text.gsub('New!', '').strip
        created_at = dehumanize_date(date)

        {
          title: title,
          url: url,
          created_at: created_at,
        }
      end
    end
  end
end

Gigbot::Parsers.register('flexjobs', Gigbot::Parsers::FlexJobs)
