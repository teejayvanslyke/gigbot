require 'yaml'
require 'feedjira'
require 'open-uri'
require_relative './gig'
require 'pp'

module Gigbot
  class Source
    SOURCES_YAML = File.dirname(__FILE__) + '/sources.yml'
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def import
      URI.open(url) do |rss|
        feed = Feedjira.parse(rss.read)
        feed.entries.each do |rss_item|
          gig = Gigbot::Gig.from_rss(rss_item)
          gig.save
        end
      end
    end

    def self.each
      source_urls  = YAML.load_file(SOURCES_YAML)
      source_urls.each do |source_url|
        yield new(source_url)
      end
    end
  end
end
