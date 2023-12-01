require 'yaml'
require 'open-uri'
require_relative './gig'
require_relative './parsers'
require 'pp'

module Gigbot
  class Source
    SOURCES_YAML = File.dirname(__FILE__) + '/sources.yml'
    attr_reader :url, :parser_name

    def initialize(url, parser_name)
      @url = url
      @parser_name = parser_name
    end

    def parser
      case parser_name
      when 'rss'
        Gigbot::Parsers::RSS
      when 'remote.co'
        Gigbot::Parsers::RemoteCo
      when 'js-remotely'
        Gigbot::Parsers::JsRemotely
      when 'rust-jobs'
        Gigbot::Parsers::RustJobs
      end
    end

    def import
      parser.parse(url)
    end

    def self.each
      definitions = YAML.load_file(SOURCES_YAML)
      definitions.each do |definition|
        yield new(definition['url'], definition['parser'])
      end
    end
  end
end
