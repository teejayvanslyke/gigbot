require 'time'
require 'ferrum'

module Gigbot
  module Parsers
    class RustJobs
      include Gigbot::Helpers::DateHelpers

      def self.parse(url)
        new.parse(url)
      end

      def parse(url)
        browser = Ferrum::Browser.new
        browser.goto(url)
        browser.network.wait_for_idle
        results = browser.at_css('.max-w-7xl > .my-5 ul')
        results.css('li').each do |entry|
          link = entry.at_css('h2 > a')
          next unless link
          title = link.text.strip
          url = "https://rustjobs.dev" + link.attribute('href')
          created_at = Time.parse(entry.at_css('time').attribute('datetime'))
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
