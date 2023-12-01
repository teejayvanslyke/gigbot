require 'yaml'
require 'feedjira'
require 'open-uri'
require_relative './gig'
require_relative './parsers'
require 'pp'

module Gigbot
  class Source
    SOURCES_YAML = File.dirname(__FILE__) + '/sources.yml'
    attr_reader :url, :parser

    def initialize(url, parser)
      @url = url
      @parser = parser
    end

    def import
      case parser
      when 'rss'
        URI.open(url) do |rss|
          feed = Feedjira.parse(rss.read)
          feed.entries.each do |rss_item|
            gig = Gigbot::Gig.from_rss(rss_item)
            gig.save
          end
        end
      when 'remote.co'
        Gigbot::Parsers::RemoteCo.parse(url)
      when 'js-remotely'
        Gigbot::Parsers::JsRemotely.parse(url)
      when 'rust-jobs'
        Gigbot::Parsers::RustJobs.parse(url)
      end
    end

    def self.each
      definitions = YAML.load_file(SOURCES_YAML)
      definitions.each do |definition|
        yield new(definition['url'], definition['parser'])
      end
    end
  end
end
