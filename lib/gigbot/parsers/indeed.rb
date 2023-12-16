require 'date'
require 'open-uri'
require 'ferrum'
require_relative '../helpers/date_helpers'
require_relative '../helpers/string_helpers'

module Gigbot
  module Parsers
    class Indeed < Base
      include Gigbot::Helpers::DateHelpers
      include Gigbot::Helpers::StringHelpers

      def title
        "Indeed"
      end

      def parse
        browser = Ferrum::Browser.new
        browser.headers.set({
          "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:120.0) Gecko/20100101 Firefox/120.0"
        })
        browser.goto(url)
        browser.network.wait_for_idle
        browser.screenshot(path: 'indeed.png')
        browser.css(".job_seen_beacon").each do |item|
          link = item.at_css('.jcs-JobTitle')
          title = link.at_css('span').text
          date = item.
            at_css(".underShelfFooter span.date").
            text.
            gsub('Posted', '').
            gsub('Active', '').
            gsub('Employer', '')
          created_at = dehumanize_date(date)
          url = "https://www.indeed.com" + link.attribute('href')

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

Gigbot::Parsers.register('indeed', Gigbot::Parsers::Indeed)
