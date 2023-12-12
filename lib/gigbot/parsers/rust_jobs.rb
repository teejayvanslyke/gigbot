require 'time'
require 'ferrum'

module Gigbot
  module Parsers
    class RustJobs < Base
      include Gigbot::Helpers::DateHelpers

      def title
        "Rust Jobs"
      end

      def parse
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
          yield({
            title: title,
            url: url,
            created_at: created_at,
          })
        end
      end
    end
  end
end

Gigbot::Parsers.register('rust-jobs', Gigbot::Parsers::RustJobs)
