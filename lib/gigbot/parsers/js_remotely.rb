require_relative '../helpers/date_helpers'
require_relative '../helpers/string_helpers'

module Gigbot
  module Parsers
    class JsRemotely < Base
      include Gigbot::Helpers::DateHelpers
      include Gigbot::Helpers::StringHelpers

      def title
        "JS Remotely"
      end

      def parse
        URI.open(url) do |file|
          doc = Nokogiri::HTML(file)
          doc.css('[data-cy="jobList"] > div').each do |entry|
            link = entry.css('[data-cy="jobTitle"] > a').first
            next unless link

            title = link.text
            url = "https://jsremotely.com" + link.attribute('href').value
            created_at = dehumanize_date(entry.css('div:last-child p').last.text)

            yield({
              title: title,
              url: url,
              created_at: created_at
            })
          end
        end
      end

      def parse_deep(gig)
        URI.open(gig.url) do |file|
          doc = Nokogiri::HTML(file)
          description = textify_html_summary(doc.xpath("//div[starts-with(@class, 'JobBody_jobBodyText')]").first.inner_html)
          return { description: description }
        end
      end
    end
  end
end

Gigbot::Parsers.register('js-remotely', Gigbot::Parsers::JsRemotely)
