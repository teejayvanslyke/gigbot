require 'date'
require 'open-uri'
require 'nokogiri'
require_relative '../helpers/date_helpers'
require_relative '../helpers/string_helpers'

module Gigbot
  module Parsers
    class JustRemoteCo < Base
      include Gigbot::Helpers::DateHelpers
      include Gigbot::Helpers::StringHelpers

      def title
        "JustRemote.co"
      end

      def parse_date(date_str)
        Date.parse(date_str).to_time
      end

      def parse
        browser = Ferrum::Browser.new
        browser.goto(url)
        browser.network.wait_for_idle
        browser.xpath("//div[starts-with(@class, 'new-job-item__jobitemwrapper')]").each do |item|
          link = item.at_xpath("//a[starts-with(@class, 'new-job-item__JobMeta')]")
          created_at = parse_date(item.at_xpath("//div[starts-with(@class, 'new-job-item__JobItemDate')]").text)
          title = item.at_css('h3').text
          url = "https://justremote.co/" + link.attribute('href')

          yield({
            title: title,
            url: url,
            created_at: created_at,
          })
        end
      end

      def parse_deep(gig)
        URI.open(gig.url) do |file|
          doc = Nokogiri::HTML(file)
          description = textify_html_summary(doc.xpath("//div[starts-with(@class, 'job-textarea__Content')]").first.inner_html)
          return { description: description }
        end
      end
    end
  end
end

Gigbot::Parsers.register('justremote.co', Gigbot::Parsers::JustRemoteCo)
