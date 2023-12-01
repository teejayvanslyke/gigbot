module Gigbot
  module Parsers
    class JsRemotely
      include Gigbot::Helpers::DateHelpers

      def self.parse(url)
        new.parse(url)
      end

      def parse(url)
        URI.open(url) do |file|
          doc = Nokogiri::HTML(file)
          doc.css('[data-cy="jobList"] > div').each do |entry|
            link = entry.css('[data-cy="jobTitle"] > a').first
            next unless link

            title = link.text
            url = "https://jsremotely.com" + link.attribute('href').value
            created_at = dehumanize_date(entry.css('div:last-child p').last.text)

            gig = Gigbot::Gig.new(
              title: title,
              url: url,
              id: Gigbot::Gig.generate_id(url),
              created_at: created_at
            )
            gig.save
          end
        end
      end
    end
  end
end
